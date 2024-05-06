class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_back(fallback_location: "posts#index")
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_back(fallback_location: "posts#index")
  end
end
