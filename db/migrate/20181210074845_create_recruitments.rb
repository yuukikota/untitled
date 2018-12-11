class CreateRecruitments < ActiveRecord::Migration[5.2]
  def change
    create_table :recruitments do |t|
      t.string :com_id
      t.string :acc_id, :limit=>20
      t.string :re_id
      t.string :chat_id
      t.string :resolved
      t.string :title, :limit => 100
      t.string :detail, :limit=>1000
      t.string :ans_com_id
      t.string :answer, :limit=>1000
      t.string :file_id

      t.timestamps
    end
  end
end
