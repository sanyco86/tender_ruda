class AddColumeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_column :users, :function, :string
    add_column :users, :phone, :string
    add_column :users, :adds, :string
    add_column :users, :www, :string
    add_column :users, :category, :string
  end
end
