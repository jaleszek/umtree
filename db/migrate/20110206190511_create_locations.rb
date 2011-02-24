class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.integer :post_id
      t.string :city
      t.string :state
      t.string :zip
      t.string :street
      t.string :country
      t.string :house_number
      

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
