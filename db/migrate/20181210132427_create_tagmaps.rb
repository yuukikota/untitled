class CreateTagmaps < ActiveRecord::Migration[5.2]
  def change
    #drop_table :tagmaps
    create_table :tagmaps do |t|
      t.integer :com_id, foreign_key: true
      t.integer :tag_id, foreign_key: true

      t.timestamps
    end
  end
end
