class AddRoleToManagers < ActiveRecord::Migration
  def change
    add_column :managers, :role, :string, default: 'read'
  end
end
