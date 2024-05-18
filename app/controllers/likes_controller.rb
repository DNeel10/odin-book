class LikesController < ApplicationController
  before_action :set_likeable, only: [:create, :destroy]
  before_action :set_like, only: [:destroy]
  before_action :authorize_user, only: [:destroy]

  def create
    @like = @likeable.likes.build
    @like.user = current_user
    @like.save

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.turbo_stream
    end
  end

  def destroy
    @like.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.turbo_stream
    end
  end

  private

    def authorize_user
      redirect_back(fallback_location: root_path, alert: 'You are not authorized to perform this action.') unless @like.user == current_user
    end

    def set_like
      @like = Like.find(params[:id])
    end
end
