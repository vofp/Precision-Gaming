class CastsController < ApplicationController
  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy

  def new
    @post = Cast.new
    @post.topic_id = params[:id]
  end

  def create
    Post
    @post = Cast.new(params[:cast])
    @post.user = current_user

    @post.winner_name = params[:post][:winner_name]
    @post.loser_name = params[:post][:loser_name]


    if @post.save
      #if ! winner = Player.where("name = ?", @post.winner_name).first
      #  winner = Player.create!(:name => @post.winner_name)
      #end
      #@post.winner_id = winner.id
      #if ! loser = Player.where("name = ?", @post.loser_name).first
      #  loser = Player.create!(:name => @post.loser_name)
      #end
      #@post.loser_id = loser.id
      flash[:success] = "Cast created!"
      redirect_to topic_path(@post.topic_id)
    else
      puts params[:cast][:topic_id]
      render :controller => "posts", :action => "new", :id => params[:cast][:topic_id]
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
