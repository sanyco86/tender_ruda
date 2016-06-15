class MoveFieldSelected < ActiveRecord::Migration
  def change
    rename_column :user_items, :selected, :selected_del
    add_column :items, :winner_id, :integer
  end
end
