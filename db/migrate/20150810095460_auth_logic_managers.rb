class AuthLogicManagers < ActiveRecord::Migration
  def change
    rename_column :managers, :password_digest, :password_digest_del
    rename_column :managers, :remember_token, :remember_token_del
    add_column :managers, :crypted_password, :string, null: false, default: ''
    add_column :managers, :password_salt, :string, null: false, default: ''
    add_column :managers, :persistence_token, :string, null: false, default: ''
    add_column :managers, :single_access_token, :string, null: false, default: ''
    add_column :managers, :perishable_token, :string, null: false, default: ''
  end
end
