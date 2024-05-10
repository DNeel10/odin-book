class LikesController < ApplicationController
  before_action :set_likeable, only: [:create]

  def create
    @like = @likeable.likes.build
    @like.user = current_user
    @like.save
  end

  def destroy
  end

end
