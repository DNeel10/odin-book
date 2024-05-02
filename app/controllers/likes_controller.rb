class LikesController < PostsController
  def create
    @like = @likeable.likes.build
    @like.user = current_user
    @like.save
  end

  def destroy

  end

  
end
