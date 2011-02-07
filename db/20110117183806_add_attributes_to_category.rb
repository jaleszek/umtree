class AddAttributesToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :parent_id, :integer
    add_column :categories, :children_count, :integer
    add_column :categories, :ancestors_count, :integer
    add_column :categories, :descendants_count, :integer
    add_column :categories, :hidden, :boolean
  end

  def self.down
    remove_column :categories, :parent_id
    remove_column :categories, :children_count
    remove_column :categories, :ancestors_count
    remove_column :categories, :descendants_count
    remove_column :categories, :hidden
  end
end
