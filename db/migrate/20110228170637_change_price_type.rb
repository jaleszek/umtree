class ChangePriceType < ActiveRecord::Migration
  def self.up
    remove_column :posts, :price
    add_column :posts, :price, :integer
  end

  def self.down
  end
end
