class RemovePasswordSaltFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password_salt, :string
    remove_column :users, :password_hash, :string
  end
end
