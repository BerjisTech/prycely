class CreateLoanApprovals < ActiveRecord::Migration[6.1]
  def change
    create_table :loan_approvals, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :loan_id

      t.timestamps
    end
  end
end
