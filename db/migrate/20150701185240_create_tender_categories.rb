class CreateTenderCategories < ActiveRecord::Migration
  def change
    create_table :tender_categories do |t|
      t.integer :tender_id
      t.integer :category_id
    end
    add_index :tender_categories, [:tender_id, :category_id], unique: true
    rename_column :tenders, :category_id, :category_id_del
  end
end
