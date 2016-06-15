class CreateUserCategories < ActiveRecord::Migration
  def change
    create_table :user_categories do |t|
      t.integer :user_id
      t.integer :category_id
    end
    add_index :user_categories, [:user_id, :category_id], unique: true
    rename_column :users, :category_id, :category_id_del
  end
end
