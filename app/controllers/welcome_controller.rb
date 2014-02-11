require 'uri'
class WelcomeController < ApplicationController
	before_filter :set_cache_buster
  def index
		respond_to do |format|
		if params[:token]
			@room = Room.active_room(params[:token])
			if @room
				format.html {render :layout => "talk"}
			else
				redirect_to root_path, :alert => "指定されたカンファレンスルームは存在しないか有効期限が切れています。再度作成してください。"
			end
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
