class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string, :city
      t.string, :street
      t.state :
      t.string, :zip
      t.string, :house_number
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
