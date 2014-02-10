require 'uri'
class WelcomeController < ApplicationController
  def index
		respond_to do |format|
		if params[:token]
			@room = Room.where(:token => params[:token]).first
			format.html {render :layout => "talk"}
		else
			format.html
		end
		end
  end
	def talk
		if request.referer
			uri = URI.parse(request.referer)
			@token = uri.path.gsub(/\//, '')
		end
	end
end
