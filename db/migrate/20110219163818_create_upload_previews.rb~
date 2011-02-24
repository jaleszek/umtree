class CreateUploadPreviews < ActiveRecord::Migration
  def self.up
    create_table :upload_previews do |t|
      t.string :img_file_name
      t.integer :img_file_size
      t.string :img_content_type
      t.timestamps
    end
  end

  def self.down
    drop_table :upload_previews
  end
end
