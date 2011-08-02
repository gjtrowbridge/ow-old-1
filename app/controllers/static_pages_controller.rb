class StaticPagesController < ApplicationController
	def index
		render :layout => 'homepage'
	end
end
