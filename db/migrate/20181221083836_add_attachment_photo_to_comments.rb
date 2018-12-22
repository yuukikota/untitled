class AddAttachmentPhotoToComments < ActiveRecord::Migration[5.2]
  def self.up
    change_table :comments do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :comments, :photo
  end
end
