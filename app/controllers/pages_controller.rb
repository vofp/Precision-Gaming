class PagesController < ApplicationController
  
  def home
    @title = "Home"
    if signed_in?
      @post = Post.new
      @post.topic_id = 1
      @feed_items = current_user.feed.paginate(:page => params[:page])
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

end
