class AddContentTypePaperclip < ActiveRecord::Migration
  def self.up
    add_column :uploads, :photo_content_type, :string
  end

  def self.down
    remove_column :uploads, :photo_content_type
  end
end
