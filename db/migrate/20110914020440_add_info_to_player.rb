class AddInfoToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :sc2ranks_link, :string
  end

  def self.down
    remove_column :players, :sc2ranks_link, :string
  end
end
