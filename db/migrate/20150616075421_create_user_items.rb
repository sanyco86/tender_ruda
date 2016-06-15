class CreateUserItems < ActiveRecord::Migration
  def change
    create_table :user_items do |t|
      t.integer :price
      t.integer :first_price
      t.integer :delivery
      t.string :comm
      t.integer :selected, null: false
      t.integer :usertender_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
