class TalkController < ApplicationController
	skip_before_filter :verify_authenticity_token
  def index
		if params[:room]
			xml = Twilio::TwiML::Response.new do |r|
				r.Dial :timeLimit => 30000 do |d|
					d.Conference params[:room]
				end
			end.text
		else
			xml = Twilio::TwiML::Response.new do |r|
				r.Say "エラーが発生しました。ルームを指定してください。", :language => 'ja-JP'
			end.text
		end
		render :layout => false, :xml => xml
  end

  def fallback
  end

  def status
  end
end
