class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.date :post_time
      t.date :update_time
      t.string :acc_id
      t.integer :p_com_id
      t.text :message
      t.integer :file_id

      t.timestamps
    end
  end
end
