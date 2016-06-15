class PrepareStatusesForDelete < ActiveRecord::Migration
  def change
    rename_table :statuses,:statuses_del
  end
end
