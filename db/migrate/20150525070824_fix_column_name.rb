class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :tenders, :admin_id, :manager_id
  end
end
