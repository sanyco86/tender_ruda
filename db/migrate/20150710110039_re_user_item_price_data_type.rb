class ReUserItemPriceDataType < ActiveRecord::Migration
  def change
    change_column :user_items, :price,  :money
    change_column :user_items, :first_price,  :money
  end
end
