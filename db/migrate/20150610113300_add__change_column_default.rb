class AddChangeColumnDefault < ActiveRecord::Migration
  def change
    change_column_default(:tenders, :status_id, 1)
  end
end
