class CostsController < ApplicationController

	before_filter :authenticate_user!, :except => [:list]
	before_filter :check_activity_ownership, :only => [:edit, :create]
	before_filter :check_cost_ownership, :except => [:list, :edit, :create]
	
	#Lists Costs
	def list
		@activity ||= Activity.find(params[:activity_id])
		@costs = @activity.costs
	end
	
	#Shows form for updating costs
	def edit
		@activity ||= Activity.find(params[:activity_id])
		@costs = @activity.costs
		@new_cost = Cost.new
	end
	
	#Changes a cost
	def update
		@cost = Cost.find(params[:id])
		
		#Update object
		if @cost.update_attributes(params[:cost])
			#If update succeeds, show activity
			flash[:notice] = "Pricing updated."
			redirect_to(:controller => 'costs', :action => 'list', :activity_id => params[:activity_id])
		else
			#Let the user try again
			@activity |= Activity.find(params[:activity_id])
			@costs |= @activity.costs
			@new_cost |= @cost
			render('edit')
		end
	end
	
	#Creates a cost
	def create
		@new_cost = Cost.new(params[:new_cost])
		@new_cost.activity_id = params[:activity_id]
		
		if @new_cost.save
			flash[:notice] = "Cost added."
			redirect_to(:controller => 'costs', :action => 'list', :activity_id => params[:activity_id])
		else
			flash[:notice] = @new_cost.errors.full_messages
			@activity ||= Activity.find(params[:activity_id])
			@costs ||= @activity.costs
			@new_cost = Cost.new
			render('edit')
		end
	end
	
	#Destroys a cost
	def destroy
		@cost ||= Cost.find(params[:id])
		@cost.destroy
		flash[:notice] = 'Cost Removed.'
		redirect_to(:action => 'list', :activity_id => @cost.activity_id)
	end
	
	private
	
	#Checks whether the activity with the "cost" in question is owned by the current user
	def check_activity_ownership()
		@activity = Activity.find(params[:activity_id])
		if user_owns_activity(@activity)
			return true
		else
			flash[:notice] = NOT_OWNER_ERROR
			redirect_to(:controller=>'costs', :action=>'list', :activity_id => params[:activity_id])
			return false
		end
	end
	
	def check_cost_ownership()
		@cost = Cost.find(params[:id])
		if user_owns_cost(@cost)
			return true
		else
			flash[:notice] = NOT_OWNER_ERROR
			redirect_to(:controller=>'costs', :action=>'list', :activity_id => @cost.activity_id)
			return false
		end
	end
	
end
