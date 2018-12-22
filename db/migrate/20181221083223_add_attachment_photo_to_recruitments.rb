class AddAttachmentPhotoToRecruitments < ActiveRecord::Migration[5.2]
  def self.up
    change_table :recruitments do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :recruitments, :photo
  end
end
