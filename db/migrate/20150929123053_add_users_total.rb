class AddUsersTotal < ActiveRecord::Migration
  def change
    add_column :user_items, :total_price, :numeric
  end
end
