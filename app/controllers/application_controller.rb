class ApplicationController < ActionController::Base
	protect_from_forgery
	
	protected
	
	#returns false if the current user does not own the passed object, otherwise true
	def user_owns_activity(activity)
		if activity.user_id == current_user.id and !current_user.blank?
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
