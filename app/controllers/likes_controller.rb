class LikesController < ApplicationController
  before_action :set_likeable, only: [:create, :destroy]

  def create
    @like = @likeable.likes.build
    @like.user = current_user
    @like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.user == current_user
      @like.destroy
      redirect_back(fallback_location: root_path)
    end
  end

end
