class ChangeUserItemsPriceDataType < ActiveRecord::Migration
  def change
    change_column :user_items, :price,  :numeric
    change_column :user_items, :first_price,  :numeric
  end
end
