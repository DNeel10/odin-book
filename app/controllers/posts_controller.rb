class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_post, only: [:show, :destroy, :edit, :update]


  def index
    @posts = Post.includes(:user, :likes).by_followed_user(current_user).order(id: :desc).limit(10)
  end

  def new
    @post = Post.new
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def update
    @post.update!(post_params)

    if @post.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.turbo_stream

      end
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@post, partial: 'posts/form', locals: { post: @post }), status: :unprocessable_entity }
    end
  end

  def create
    @post = current_user.posts.create(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @comments = @post.comments.includes(:comments)
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
