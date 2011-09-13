class Player < ActiveRecord::Base
  has_many :game_wins, :class_name => "Cast", :foreign_key => "winner_id"
  has_many :game_loses, :class_name => "Cast", :foreign_key => "loser_id"
  def games
    game_wins + game_loses
  end
end
