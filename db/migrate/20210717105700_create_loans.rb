class CreateLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :loans do |t|
      t.integer :group_id
      t.integer :created_by
      t.integer :user_id
      t.float :amount
      t.integer :type
      t.float :amount_due
      t.integer :interest
      t.integer :status
      t.text :guarantors
      t.timestamp :date_granted
      t.timestamp :date_due
      t.timestamp :date_paid
      t.text :requirements

      t.timestamps
    end
  end
end
