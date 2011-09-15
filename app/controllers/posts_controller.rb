class PostsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy

  def new
    if params[:id] == "3"
      Post
      @post = Cast.new
      puts @post
    else
      @post = Post.new
    end
    @post.topic_id = params[:id]
  end

  def create
    puts params[:post]
    if params[:post][:topic_id] == "3"
      Post
      @post = Cast.new(params[:post])
      @post.user = current_user
    else

      @post  = current_user.posts.build(params[:post])
    end
    if @post.save
      flash[:success] = "Post created!"
      redirect_to topic_path(@post.topic_id)
    else
      error = @post.save
      @post  = current_user.posts.build(params[:post])
      @post.errors = error
      render :action => "new", :id => params[:post][:topic_id]
    end
  end

  def show
    @post = Post.find(params[:id])
    @microposts = @post.microposts.paginate(:page => params[:page],:per_page => 10)
    @micropost = Micropost.new
    @micropost.post_id = @post.id
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
