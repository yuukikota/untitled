class CreateRecruitments < ActiveRecord::Migration[5.2]
  def change
    create_table :recruitments do |t|
      t.datetime :post_time
      t.datetime :update_time
      t.string :acc_id
      t.integer :chat_id
      t.boolean :resolved
      t.string :title
      t.text :detail
      t.string :ans_com_id
      t.string :integer
      t.text :answer
      t.integer :file_id

      t.timestamps
    end
  end
end
