class AddColumnToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :acc_id       , :string, null: false
    add_index  :accounts, :acc_id, unique: true
    add_column :accounts, :name         , :string, null: false
    add_column :accounts, :grade        , :string, null: false
    add_column :accounts, :university   , :string, null: false
    add_column :accounts, :faculty      , :string, null: false
    add_column :accounts, :department   , :string, null: false
    add_column :accounts, :introduction , :string, null: false, default: ""
  end
end
