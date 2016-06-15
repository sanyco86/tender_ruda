class RemoteToTenderColume < ActiveRecord::Migration
def change
    remove_column :tenders, :more_category, :string
    remove_column :tenders, :manager_comm, :string
    remove_column :tenders, :data_start_2, :datetime
    remove_column :tenders, :data_end_2, :datetime
  end
end
