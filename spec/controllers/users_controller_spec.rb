require 'spec_helper'

describe UsersController do
  describe "GET root" do
    before do
      xhr :get, :index
    end

    it "should be success" do
      response.should be_success
    end
  end

  describe "POST 'users/create'" do
    before do
      xhr :post, :create, iidxid: "1111-1111", djname: "test"
    end

    it "should be success" do
      response.should be_success
    end

    it "should NOT create duplicate iidxid user" do
      xhr :post, :create, iidxid: "1111-1111", djname: "test"
      User.where(iidxid: "1111-1111").size.should == 1
    end
  end
end
