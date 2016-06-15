class AddRememberTokenToManagers < ActiveRecord::Migration
  def change
    add_column :managers, :remember_token, :string
    add_index  :managers, :remember_token
  end
end
