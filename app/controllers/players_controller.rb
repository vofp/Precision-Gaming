class PlayersController < ApplicationController
  def index
    @players = Player.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end
  def show
    @player = Player.find(params[:id])
    @title = @player.name
  end
end
