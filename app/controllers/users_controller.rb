class UsersController < ApplicationController
	
	#Processes a form for new user creation
	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:notice] = "Username: '#{@user.username}' was created successfully.  Please check your email to activate the username."
			
			#email user
			flash[:notice] = @user.activation_key
			
			redirect_to(:controller => 'activities', :action => 'list')
		else
			flash[:notice] = @user.errors.full_messages
			render('new')
		end
	end
	
	#Activates a newly-registered user account
	def activate
		@user = User.find(params[:id])
		if @user.activated?
			flash[:notice] = ACTIVATION_ERROR
			redirect_to(:controller=>'static_pages', :action => 'index')
		elsif @user.activation_key == params[:code]
			@user.activated = true
			@user.activation_key = nil
			@user.save
			flash[:notice] = "The user: '#{@user.username}' has been successfully activated."
			redirect_to(:controller=>'users', :action=>'login')
		else
			flash[:notice] = ACTIVATION_ERROR
			redirect_to(:controller=>'static_pages', :action => 'index')
		end
	end
	
	#Shows a form for new user creation
	def new
		@user = User.new
	end
	
	#Shows a login form
	def login
		if session[:user_id]
			flash[:notice] = "You are already logged in as #{session[:username]}."
			redirect_to(:controller=>'activities', :action=>'list')
		end
	end
	
	#Attempts to log in a user
	def attempt_login
		authorized_user = User.authenticate(params[:username], params[:password])
		if authorized_user
			session[:user_id] = authorized_user.id
			session[:username] = authorized_user.username
			session[:user_activated] = authorized_user.activated
			flash[:notice] = "You are now logged in."
			redirect_to(:controller => 'activities', :action => 'list')
		else
			flash[:notice] = "Invalid username/password combination."
			redirect_to(:controller => 'activities', :action => 'list')
		end
	end
	
	#Logs out a user
	def logout
		flash[:notice] = "Later, #{session[:username]}"
		session[:user_id] = nil
		session[:username] = nil
		redirect_to(:controller => 'activities', :action => 'list')
	end
end
