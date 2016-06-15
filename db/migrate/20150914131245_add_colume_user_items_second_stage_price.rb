class AddColumeUserItemsSecondStagePrice < ActiveRecord::Migration
  def change
    add_column :user_items, :first_price_second_stage, :numeric
  end
end
