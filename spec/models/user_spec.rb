require 'spec_helper'

describe User do
  fixtures :users

  before do
    @user = users(:valid)
  end

  it "must have :iidxid, :djname" do
    [:iidxid, :djname].each do |sym|
      invalid_users = @user
      invalid_users[sym] = ""
      invalid_users.should_not be_valid
    end
  end
end
