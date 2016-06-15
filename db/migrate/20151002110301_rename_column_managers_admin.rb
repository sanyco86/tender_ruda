class RenameColumnManagersAdmin < ActiveRecord::Migration
  def change
    rename_column :managers, :admin, :admin_del
  end
end
