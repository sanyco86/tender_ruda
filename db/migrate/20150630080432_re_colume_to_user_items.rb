class ReColumeToUserItems < ActiveRecord::Migration
  def change
    remove_column :user_items, :selected, :integer
    add_column :user_items, :selected, :boolean, default: false
  end
end
