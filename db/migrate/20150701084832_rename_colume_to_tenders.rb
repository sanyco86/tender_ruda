class RenameColumeToTenders < ActiveRecord::Migration
  def change
    remove_column :tenders, :etaps, :integer
    add_column :tenders, :etap, :integer, default: 1
  end
end
