class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.text :activity
      t.integer :user_id
      t.integer :wallet_id
      t.integer :group_id

      t.timestamps
    end
  end
end
