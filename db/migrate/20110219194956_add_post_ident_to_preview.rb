class AddPostIdentToPreview < ActiveRecord::Migration
  def self.up
    add_column :upload_previews, :post_ident, :string
  end

  def self.down
    remove_column :upload_previews, :post_ident
  end
end
