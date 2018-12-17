class CreateUnivinfos < ActiveRecord::Migration[5.2]
  def change
    #drop_table :univinfos
    create_table :univinfos,id: false do |t|
      t.integer :infoid
      t.integer :p_id
      t.integer :stat, null:false
      t.string  :name, null:false
      t.integer :tag_id, null:false

      t.timestamps
    end
    execute "ALTER TABLE univinfos ADD PRIMARY KEY (infoid);"
  end
end
