class TalkController < ApplicationController
  skip_before_filter :verify_authenticity_token
	before_filter:validate_request
  include PhoneUtils
  def index
    if params[:room]
      xml = Twilio::TwiML::Response.new do |r|
        r.Dial :timeLimit => 30000, :endConferenceOnExit => true, :startConferenceOnEnter => true do |d|
          d.Conference params[:room]
        end
      end.text
    elsif params[:Digits]
      @room = Room.validated_room(params[:Digits])
      if @room
        xml = Twilio::TwiML::Response.new do |r|
          r.Dial :timeLimit => 30000, :endConferenceOnExit => true, :startConferenceOnEnter => true do |d|
            d.Conference @room[:token]
          end
        end.text
      else
        xml = Twilio::TwiML::Response.new do |r|
          r.Say "エラーが発生しました。指定されたルームが見つかりませんでした。", :language => 'ja-JP'
        end.text
      end
    elsif params[:To] == parse_phone_number(Settings.service_phone)
      xml = Twilio::TwiML::Response.new do |r|
        r.Gather :numDigits => Settings.activation_code_digits, :action => "/talk" do |g|
          g.Say "#{Settings.activation_code_digits}桁の確認コードを入力してください。", :language => 'ja-JP'
        end
      end.text
    else
      xml = Twilio::TwiML::Response.new do |r|
        r.Say "エラーが発生しました。ルームを指定してください。", :language => 'ja-JP'
      end.text
    end
    render :layout => false, :xml => xml
  end

  def finish
    logger.debug(params.inspect)
    render :text => "", :layout => false
  end

  def fallback
  end

  def status
    if params[:CallStatus] == "completed"
      # delete
    end
  end

	def validate_request
		@validator = Twilio::Util::RequestValidator.new Settings.auth_token
		@validator.validate(request.url, params.except(:action, :controller), request.headers['X-Twilio-Signature'])
	end
end
