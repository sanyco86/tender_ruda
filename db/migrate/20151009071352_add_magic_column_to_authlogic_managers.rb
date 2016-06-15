class AddMagicColumnToAuthlogicManagers < ActiveRecord::Migration
  def change
    add_column :managers, :login_count, :integer, default: 0, null: false
    add_column :managers, :failed_login_count, :integer,  default: 0, null: false
    add_column :managers, :last_request_at, :datetime
    add_column :managers, :current_login_at, :datetime
    add_column :managers, :last_login_at, :datetime
    add_column :managers, :current_login_ip, :string
    add_column :managers, :last_login_ip, :string
  end
end
