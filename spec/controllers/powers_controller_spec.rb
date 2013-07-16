require 'spec_helper'

describe PowersController do
  describe "POST 'scores/update'" do
    before do
      xhr :get, :index
    end

    it "should be success" do
      response.should be_success
    end
  end
end
