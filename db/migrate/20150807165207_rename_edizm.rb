class RenameEdizm < ActiveRecord::Migration
  def change
    rename_table :edizms, :measure_units
    rename_column :items, :edizm_id, :edizm_del
    add_column :items, :measure_unit, :string, null: false, default: 'шт.'
  end
end
