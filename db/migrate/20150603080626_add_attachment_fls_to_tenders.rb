class AddAttachmentFlsToTenders < ActiveRecord::Migration
  def self.up
    change_table :tenders do |t|
      t.attachment :fls
    end
  end

  def self.down
    remove_attachment :tenders, :fls
  end
end
