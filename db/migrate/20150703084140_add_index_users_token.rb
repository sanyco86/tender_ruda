class AddIndexUsersToken < ActiveRecord::Migration
  def change
    add_index :users, :perishable_token
  end
end
