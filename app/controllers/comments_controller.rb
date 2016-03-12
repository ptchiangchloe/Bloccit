class CommentsController < ApplicationController
  def show
    @comment = Comment.find(params[:id])
  end

  before_action :require_sign_in

   def create
     @topic = Topic.find(params[:topic_id])
     comment = @topic.comments.new(comment_params)
     comment.user = current_user

     if comment.save
       flash[:notice] = "Comment saved successfully."
       redirect_to @topic
     else
       flash[:alert] = "Comment failed to save."
       redirect_to @topic
     end
   end

   before_action :authorize_user, only: [:destroy]
   def destroy
     @topic = Topic.find(params[:topic_id])
     comment = @topic.comments.find(params[:id])

     if comment.destroy
       flash[:notice] = "Comment was deleted."
       redirect_to @topic
     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
       redirect_to @topic
     end
   end

   private
   def authorize_user
     comment = Comment.find(params[:id])
     unless current_user == comment.user || current_user.admin?
       flash[:alert] = "You do not have permission to delete a comment."
       redirect_to @topic
     end
   end

   def comment_params
     params.require(:comment).permit(:body)
   end
end
