class ApplicationController < ActionController::Base
	protect_from_forgery
	
	protected
	
	def confirm_logged_in
		if session[:user_id] && session[:user_activated] == true
			return true
		elsif !session[:user_id]
			flash[:notice] = NOT_LOGGED_IN_ERROR
			redirect_to(:controller => 'users', :action => 'login')
			return false
		elsif session[:user_activated] == false
			flash[:notice] = NOT_ACTIVATED_ERROR
			redirect_to(:controller => 'activities', :action => 'list')
			return false
		end
	end
	
	#returns false if the current user does not own the passed object, otherwise true
	def user_owns_activity(activity)
		if activity.user_id == session[:user_id] and !session[:user_id].blank?
			return true
		else
			return false
		end
	end
	
	#Checks whether a user owns a cost
	def user_owns_cost(cost)
		@activity ||= Activity.find(Cost.activity_id)
		return user_owns_activity(activity)
	end
	
	#Checks whether the current user is an admin
	def user_is_admin
		@user ||= User.find(session[:user_id])
		return @user.is_admin?
	end
	
end
