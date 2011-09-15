class MicropostsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy

  def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      if (@micropost.post.is_cast?)
        redirect_to cast_path(@micropost.post_id)
      else
        redirect_to post_path(@micropost.post_id)
      end
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted!"
    redirect_back_or root_path
  end
  
  private

    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
  
end
