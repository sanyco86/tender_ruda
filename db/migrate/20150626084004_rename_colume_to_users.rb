class RenameColumeToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :category, :category_id
  end
end
