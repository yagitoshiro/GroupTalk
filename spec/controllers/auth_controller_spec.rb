require 'spec_helper'

describe AuthController do

  describe "GET 'token'" do
    it "returns http success" do
      get 'token'
      response.should be_success
    end
  end

end
