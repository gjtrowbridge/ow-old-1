class LocationsController < ApplicationController
	before_filter :check_user_for_ownership, :except => [:list, :destroy]
	
	#Lists locations
	def list
		@activity ||= Activity.find(params[:activity_id])
		@locations = @activity.locations
	end
	
	#Shows form for updating locations
	def edit
		@activity ||= Activity.find(params[:activity_id])
		@locations = @activity.locations
		@new_location = Location.new
	end
	
	#Changes a location
	def update
		@location = Location.find(params[:location][:id])
		
		#Update object
		if @location.update_attributes(params[:location])
			#If update succeeds, show activity
			flash[:notice] = "Pricing updated."
			redirect_to(:controller => 'locations', :action => 'list', :activity_id => params[:activity_id])
		else
			#Let the user try again
			@activity |= Activity.find(params[:activity_id])
			@locations |= @activity.locations
			@new_location |= @location
			render('edit')
		end
	end
	
	#Creates a location
	def create
		@new_location = Location.new(params[:new_location])
		@new_location.activity_id = params[:activity_id]
		
		if @new_location.save
			flash[:notice] = "Pricing updated."
			redirect_to(:controller => 'locations', :action => 'list', :activity_id => params[:activity_id])
		else
			flash[:notice] = @new_location.errors.full_messages
			@activity ||= Activity.find(params[:activity_id])
			@locations ||= @activity.locations
			@new_location = location.new
			render('edit')
		end
	end
	
	#Destroys a location
	def destroy
		@location = Location.find(params[:id])
		if check_location_for_ownership(@location)
			flash[:notice] = 'Pricing updated.'
			@location.destroy
			redirect_to(:action => 'list', :activity_id => @location.activity_id)
		else
			redirect_to(:action => 'list', :activity_id => @location.activity_id)
		end
	end
	
	private
	
	#Checks whether the activity with the "location" in question is owned by the current user
	def check_location_for_ownership(location)
		@activity ||= location.activity
		if @activity.user_id == session[:user_id] and session[:user_id] != nil
			return true
		elsif session[:user_id] == nil
			flash[:notice] = "You must be logged in to do that."
			return false
		else
			flash[:notice] = "You do not have permission to modify that activity's locations"
			return false
		end
	end
	
	def check_user_for_ownership()
		@activity ||= Activity.find(params[:activity_id])
		activity_user_id = @activity.user_id
		if check_activity_against_current_user(activity_user_id)
			return true
		else
			redirect_to(:controller=>'locations', :action => 'list', :activity_id => params[:activity_id])
			return false
		end
	end
	
end
