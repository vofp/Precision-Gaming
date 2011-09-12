class AddCastToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :winner_id, :integer
    add_column :posts, :loser_id, :integer
    add_column :posts, :title, :string
    add_column :posts, :location, :string
    add_column :posts, :link, :string
    add_column :posts, :type, :string
  end

  def self.down
    remove_column :posts, :winner_id, :integer
    remove_column :posts, :loser_id, :integer
    remove_column :posts, :title, :string
    remove_column :posts, :location, :string
    remove_column :posts, :link, :string
    remove_column :posts, :type, :string
  end
end
