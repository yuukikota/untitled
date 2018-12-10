class CreateEntryChats < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_chats do |t|
      t.integer :chat_id
      t.string :acc_id

      t.timestamps
    end
  end
end
