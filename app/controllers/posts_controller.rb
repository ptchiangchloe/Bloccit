class PostsController < ApplicationController

  before_action :require_sign_in, except: :show


  def show
    @post = Post.find(params[:id])
  end

  def new
    authorize! :new, @post
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    authorize! :create, @post
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post was saved."
      #redirect_to @post
      redirect_to [@topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    authorize! :edit, @post
    @post = Post.find(params[:id])
  end

  def update
    authorize! :update, @post
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      #redirect_to @post
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @post
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
       #redirect_to posts_path
       redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  def  post_params
    params.require(:post).permit(:title, :body)
  end
end
