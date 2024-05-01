class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  
  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @comment.save

    if @comment.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
