class AddAttachmentFileToUsers < ActiveRecord::Migration

    def self.up
    change_table :users do |t|
      t.attachment :file_nds
      t.attachment :file_reg
    end
  end

  def self.down
    remove_attachment :users, :file_nds
    remove_attachment :users, :file_reg
  end

end
