class ChangePriceType < ActiveRecord::Migration
  def self.up
    remove_column :posts, :price
    add_column :posts, :price, :float
  end

  def self.down
  end
end
