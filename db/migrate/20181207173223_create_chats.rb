class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :com_id
      t.integer :capacity

      t.timestamps
    end
  end
end
