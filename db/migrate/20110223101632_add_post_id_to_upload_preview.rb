class AddPostIdToUploadPreview < ActiveRecord::Migration
  def self.up
    add_column :upload_previews, :post_id, :integer
  end

  def self.down
    remove_column :upload_previews, :post_id
  end
end
