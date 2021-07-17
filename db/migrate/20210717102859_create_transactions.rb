class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.float :amount
      t.text :transaction_reference
      t.integer :transaction_type
      t.integer :group_id
      t.integer :wallet_id
      t.integer :status
      t.integer :transaction_mode
      t.text :description
      t.text :category
      t.text :sub_category

      t.timestamps
    end
  end
end
