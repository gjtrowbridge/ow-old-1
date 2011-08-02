class ActivitiesController < ApplicationController
	
	#Restricts access
	before_filter :authenticate_user!, :except => [:index, :list, :show]
	before_filter :check_activity_ownership, :except => [:index, :list, :show, :new, :create]
	
	#Defaults to the list method
	def index
		list
		render('list')
	end
	
	#Shows a specific activity
	def show
		@activity ||= Activity.find(params[:id])
		@creator ||= User.find(@activity.user_id).username
	end

	#Provides form for updating activity
	def edit
		@activity ||= Activity.find(params[:id])
	end
	
	#Processes an update request
	def update
		#Find object using id
		@activity ||= Activity.find(params[:id])
		
		#Update object
		if @activity.update_attributes(params[:activity])
			#If update succeeds, show activity
			flash[:notice] = "The activity: \"#{@activity.name}\" was successfully updated."
			redirect_to(:controller => 'activities', :action => 'show', :id => @activity.id)
		else
			#Let the user try again
			render('edit')
		end
	end
	
	#Shows a form for new activity creation
	def new
		@activity = Activity.new
	end

	#Processes a new activity creation request
	def create
		@activity = Activity.new(params[:activity])
		@activity.user_id = session[:user_id]
		if @activity.save
			flash[:notice] = "The activity: \"#{@activity.name}\" was successfully created."
			redirect_to(:controller => 'activities', :action => 'list')
		else
			flash[:notice] = @activity.errors.full_messages
			render('new')
		end
	end

	#Lists all activities
	def list
		@activities = Activity.order("activities.name ASC")
	end
	
	def delete()
		@activity ||= Activity.find(params[:id])
	end
	
	def destroy
		@activity ||= Activity.find(params[:id])
		@activity.destroy
		flash[:notice] = "The activity: \"#{@activity.name}\" was successfully deleted."
		redirect_to(:action => 'list')
	end
	
	private
	
	#Used to make sure users can ONLY modify activities they themselves created.
	def check_activity_ownership()
		@activity = Activity.find(params[:id])
		if user_owns_activity(@activity)
			return true
		else
			flash[:notice] = NOT_OWNER_ERROR
			redirect_to(:controller=>'activities', :action => 'list')
			return false
		end
	end
	
	
end