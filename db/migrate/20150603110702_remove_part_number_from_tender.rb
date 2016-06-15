class RemovePartNumberFromTender < ActiveRecord::Migration
  def change
    remove_column :tenders, :files, :string
  end
end
