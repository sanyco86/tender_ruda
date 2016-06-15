class CreateTenders < ActiveRecord::Migration
  def change
    create_table :tenders do |t|
      t.string :name
      t.integer :category_id
      t.integer :status_id
      t.string :uslovie
      t.string :dopuslovie
      t.datetime :data_start
      t.datetime :data_end
      t.string :files
      t.integer :admin_id
      t.string :more_category
      t.string :manager_comm
      t.datetime :data_start_2
      t.datetime :data_end_2
      t.integer :etaps

      t.timestamps null: false
    end
  end
end
