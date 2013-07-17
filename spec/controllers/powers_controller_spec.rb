require 'spec_helper'

describe PowersController do
  describe "GET 'powers/update'" do
    before do
      User.create(iidxid: "1111-1111", djname: "test")
      xhr :get, :update, iidxid: "1111-1111"
    end

    it "should be success" do
      response.should be_success
    end
  end
end
