class ConvertLoansLoanTypeToUuid < ActiveRecord::Migration[6.1]
  def up
    execute "ALTER TABLE loans ALTER COLUMN loan_type SET DATA TYPE UUID USING (uuid(lpad(replace(text(loan_type),'-',''), 32, '0')));"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
