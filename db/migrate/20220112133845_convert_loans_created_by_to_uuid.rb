class ConvertLoansCreatedByToUuid < ActiveRecord::Migration[6.1]
  def up
    execute "ALTER TABLE loans ALTER COLUMN created_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(created_by),'-',''), 32, '0')));"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
