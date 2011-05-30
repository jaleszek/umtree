class AddConfirmationFieldToAccount < ActiveRecord::Migration
  def self.up
    add_column :users, :email_confirmation, :boolean
    add_column :users, :email_confirmation_hash, :string
  end

  def self.down
    remove_column :users, :email_confirmation
    remove_column :users, :email_confirmation_hash
  end
end
