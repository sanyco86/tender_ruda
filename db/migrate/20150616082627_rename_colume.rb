class RenameColume < ActiveRecord::Migration
  def change
    rename_column :user_items, :usertender_id, :user_tender_id
  end
end
