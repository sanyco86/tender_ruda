class AddIndexes < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
    add_index :categories, :name, unique: true
    add_index :edizms, :name, unique: true
    add_index :statuses, :name, unique: true
  end
end
