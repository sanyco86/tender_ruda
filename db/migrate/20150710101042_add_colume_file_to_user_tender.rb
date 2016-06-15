class AddColumeFileToUserTender < ActiveRecord::Migration
  def self.up
    change_table :user_tenders do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :users, :file
  end
end
