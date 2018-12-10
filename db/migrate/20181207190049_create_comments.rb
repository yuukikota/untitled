class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.datetime :post_time
      t.datetime :update_time
      t.string :acc_id
      t.integer :p_com_id
      t.integer :p_com_type
      t.text :message
      t.integer :file_id

      t.timestamps
    end
  end
end
