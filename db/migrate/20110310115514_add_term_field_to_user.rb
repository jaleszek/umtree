class AddTermFieldToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :terms, :boolean
  end

  def self.down
    remove_column :users, :terms
  end
end
