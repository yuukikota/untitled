class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string  :acc_id   , null:false, limit: 20
      t.integer :p_com_id , null:false
      t.string  :message  , null:false, limit: 1000
      t.integer :file_id

      t.timestamps
    end
    add_index :comments, :p_com_id
  end
end