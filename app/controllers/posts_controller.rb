class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_post, only: [:show, :delete, :edit, :update]

  def index
    @posts = Post.all
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
  end

  def delete
    @post.destroy
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
