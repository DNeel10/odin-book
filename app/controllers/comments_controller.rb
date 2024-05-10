class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable, only: [:create, :new]
  
  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    @comment.save

    if @comment.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  

  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end

end
