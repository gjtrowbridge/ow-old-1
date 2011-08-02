class StaticPagesController < ApplicationController
	def index
		render :layout => 'homepage'
	end
	def send_mail
		UserMailer.test.deliver
		flash[:notice] = 'mail sent'
		redirect_to(root_path)
	end
end
