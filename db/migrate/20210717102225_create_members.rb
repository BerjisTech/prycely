class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.integer :invited_by
      t.integer :user_id
      t.integer :group_id
      t.text :designation
      t.text :status
      t.timestamp :invited_on
      t.timestamp :accepted_on
      t.text :paid_member
      t.integer :amount

      t.timestamps
    end
  end
end
