require 'settings'
class AuthController < ApplicationController
	before_filter :set_cache_buster

  def token
		if request.xhr?
    	capability = Twilio::Util::Capability.new Settings.account_sid, Settings.auth_token
    	capability.allow_client_outgoing Settings.app_sid
			render :text => capability.generate, :layout => false
		end
  end

end
