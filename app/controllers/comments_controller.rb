class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

   def create
     if params[:post_id]
       @parent = Post.find(params[:post_id])
     elsif params[:topic_id]
       @parent = Topic.find(params[:topic_id])
     end
     comment = Comment.new(comment_params)
     comment.user = current_user
     @parent.comments << comment

     if comment.save
       flash[:notice] = "Comment saved successfully."
       redirect_to @parent
     else
       flash[:alert] = "Comment failed to save."
       redirect_to @parent
     end
   end

   def destroy
     if params[:post_id]
       @parent = Post.find(params[:post_id])
     elsif params[:topic_id]
       @parent = Topic.find(params[:topic_id])
     end
     comment = @parent.comments.find(params[:id])

     if comment.destroy
       flash[:notice] = "Comment was deleted."
       redirect_to @parent
     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
       redirect_to @parent
     end
   end

   private
   def authorize_user
     comment = Comment.find(params[:id])
     unless current_user == comment.user || current_user.admin?
       flash[:alert] = "You do not have permission to delete a comment."
       redirect_to @parent
     end
   end

   def comment_params
     params.require(:comment).permit(:body)
   end
end
