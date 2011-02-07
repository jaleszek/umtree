class AddLocationFields < ActiveRecord::Migration
  def self.up
    add_column :locations, :post_id, :integer
    add_column :locations, :city, :string
    add_column :locations, :state, :string
    add_column :locations, :zip, :string
    add_column :locations, :street, :string
    add_column :locations, :house_number, :string
    add_column :locations, :country, :string
    
  end

  def self.down
    remove_column :locations, :post_id
    remove_column :locations, :city
    remove_column :locations, :state
    remove_column :locations, :zip  
    remove_column :locations, :house_number
    remove_column :locations, :country
    remove_column :locations, :street
  end
end
