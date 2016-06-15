class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :quantity
      t.integer :edizm_id
      t.string :gost
      t.string :description
      t.integer :tender_id

      t.timestamps null: false
    end
  end
end
