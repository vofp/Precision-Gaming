class PagesController < ApplicationController
  
  def home
    @title = "Home"
    if signed_in?
      @post = Post.new
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

  def forum
    @important = Post.where(:topic_id => 1).limit(3)
    @event = Post.where(:topic_id => 2).limit(3)
    @cast = Post.where(:topic_id => 3).limit(3)
    @replay = Post.where(:topic_id => 4).limit(3)
    @other = Post.where(:topic_id => 5).limit(3)
  end
end
