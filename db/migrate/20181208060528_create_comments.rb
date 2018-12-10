class CreateComments < ActiveRecord::Migration[5.2]
  def change
    #drop_table :comments
    create_table :comments, id: false do |t|
      t.integer :com_id, null:false
      t.datetime :post_time, null:false
      t.datetime :update_time, null:false
      t.string :acc_id, limit: 20, null:false
      t.integer :p_com_id
      t.string :message, limit: 1000, null:false
      t.integer :file_id

      t.timestamps
    end
    execute "ALTER TABLE comments ADD PRIMARY KEY (com_id);"
  end
end