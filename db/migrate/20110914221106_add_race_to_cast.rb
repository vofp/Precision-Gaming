class AddRaceToCast < ActiveRecord::Migration
  def self.up
    add_column :posts, :winner_race, :integer
    add_column :posts, :loser_race, :integer
    add_column :posts, :game_type, :string
  end

  def self.down
    remove_column :posts, :winner_race, :integer
    remove_column :posts, :loser_race, :integer
    remove_column :posts, :game_type, :string
  end
end
