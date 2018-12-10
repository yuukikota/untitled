class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :com_id
      t.string :acc_id, :limit=>20
      t.string :re_id, :limit=>20
      t.string :message, :limit=>1000
      t.string :file_id

      t.timestamps
    end
  end
end
