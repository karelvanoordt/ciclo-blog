class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    new_like = current_user.likes.new(
      user_id: current_user.id,
      post_id: @post.id
    )
    new_like.update_likes_counter
    if new_like.save
      redirect_to "/users/#{@post.user_id}/posts/#{@post.id}", flash: { alert: 'Liked!' }
    else
      redirect_to "/users/#{@post.user_id}/posts/#{@post.id}",
                  flash.now[:error] = 'An error occured, like could not be saved'
    end
  end
end
