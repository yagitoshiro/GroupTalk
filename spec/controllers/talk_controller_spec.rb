require 'spec_helper'

describe TalkController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'fallback'" do
    it "returns http success" do
      get 'fallback'
      response.should be_success
    end
  end

  describe "GET 'status'" do
    it "returns http success" do
      get 'status'
      response.should be_success
    end
  end

end
