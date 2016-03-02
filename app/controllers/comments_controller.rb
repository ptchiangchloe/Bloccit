class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]


  def create
    id = params[:post_id] || params[:topic_id]
    if params[:post_id]
      @parent = Post.find(params[:post_id])
    elsif params[:topic_id]
      @parent = Topic.find(params[:topic_id])
    end
    comment = @parent.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@parent.topic, @parent]
    else
      flash.now[:alert] = "There was an error saving the comment. Please try again."
      redirect_to [@parent.topic, @parent]
    end
  end

  def destroy
    @parent = params[:post_id] || params[:topic_id]
    comment = @parent.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted successfully."
      redirect_to [@parent.topic, @parent]
    else
      flash.now[:alert] = "There was an error deleting the comment."
      redirect_to [@parent.topic, @parent]
    end
  end

  def comment_params
    params.require(:comment).permit(:x, :y)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user.admin? || current_user == comment.user
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end
end
