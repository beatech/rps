class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    if params[:iidxid] =~ /[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]/
      @user = User.where(iidxid: params[:iidxid]).first
      @user ||= User.create(iidxid: params[:iidxid], djname: params[:djname])
      @user.update_attributes(djname: params[:djname])
      render text: "create succeeded"
    else
      render text: "invalid iidxid"
    end
  end
end
