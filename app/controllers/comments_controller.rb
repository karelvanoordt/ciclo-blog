class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @new_comment = current_user.comments.new(
      text: comment_params,
      user_id: current_user.id,
      post_id: @post.id
    )
    @new_comment.post_id = @post.id
    @new_comment.update_comments_counter
    if @new_comment.save
      redirect_to "/users/#{@post.user_id}/posts/#{@post.id}", flash: { alert: 'Comment created' }
    else
      flash.now[:error] = 'An error ocurred, could not save comment'
      render action: 'new'
    end
  end

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end