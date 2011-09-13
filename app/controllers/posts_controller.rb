class PostsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy

  def new
    @post = Post.new
    @post.topic_id = params[:id]
  end

  def create
    @post  = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to topic_path(@post.topic_id)
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted!"
    redirect_back_or root_path
  end
  
  private

    def authorized_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_path if @post.nil?
    end
  
end
