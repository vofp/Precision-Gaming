class AddPostIdToMicropost < ActiveRecord::Migration
  def self.up
    add_column :microposts, :post_id, :integer
    add_index :microposts, :post_id
  end

  def self.down
    remove_column :microposts, :post_id
  end
end
