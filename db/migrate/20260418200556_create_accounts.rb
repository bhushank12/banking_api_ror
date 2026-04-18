class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :account_number
      t.decimal :balance
      t.string :ifsc_code
      t.string :branch_name
      t.text :address

      t.timestamps
    end

    add_index :accounts, :account_number, unique: true
  end
end
