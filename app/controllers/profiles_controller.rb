class ProfilesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:edit, :update]

  def create
  end

  def show
    @profile = Profile.find_or_create_by(user_id: params[:user_id])
  end

  def edit
    @profile = @user.profile
  end

  def update
    @profile = @user.profile
    if @profile.update(profile_params)
      redirect_to user_profile_path, notice: "Profile was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

   def set_user
    @user = User.find(params[:user_id])
   end

   def profile_params
    params.require(:profile).permit(:name, :birthday, :about, user_attributes: [:id, :avatar])
   end

   def authorize_user
    redirect_to root_path, notice: "Cannot edit another user's profile" unless current_user == @user
   end
end
