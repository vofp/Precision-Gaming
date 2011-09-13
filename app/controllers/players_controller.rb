class PlayersController < ApplicationController
  def index
    @players = Player.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end
end
