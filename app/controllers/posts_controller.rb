class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_post, only: [:show, :destroy, :edit, :update]

  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def update
    @post.update!(post_params)

    if @post.save
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @post = current_user.posts.create(post_params)

    respond_to do |format|
      if @post.save
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post.destroy

    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
