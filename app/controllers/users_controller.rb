class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.includes(:profile, { avatar_attachment: :blob }, :followed_users).all
  end
end
