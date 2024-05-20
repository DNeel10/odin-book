class CommentsController < ApplicationController
  before_action :set_commentable, only: [:new, :create]
  before_action :authenticate_user!

  
  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    @comment.save

    if @comment.save
      redirect_back(fallback_location: root_path)

    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end

end
