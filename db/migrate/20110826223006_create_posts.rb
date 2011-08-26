class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :topic_id
      t.text :content
      t.integer :user_id

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :topic_id
  end

  def self.down
    drop_table :posts
  end
end
