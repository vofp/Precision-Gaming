class TopicsController < ApplicationController
  def index
    @important = Post.where(:topic_id => 1).limit(3)
    @event = Post.where(:topic_id => 2).limit(3)
    @cast = Post.where(:topic_id => 3).limit(3)
    @replay = Post.where(:topic_id => 4).limit(3)
    @other = Post.where(:topic_id => 5).limit(3)
  end
  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts.paginate(:page => params[:page],:per_page => 10)
  end
end
