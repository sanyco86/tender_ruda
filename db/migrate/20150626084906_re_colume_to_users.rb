class ReColumeToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :category_id, :string
    add_column :users, :category_id, :integer
  end
end
