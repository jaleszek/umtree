class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :category_id
      t.integer :user_id
      t.string :price
      t.string :content
      t.string :alt_city
      t.string :alt_street
      t.string :title


      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
