# frozen_string_literal: true

class ConvertLoansForeignIdKeysToUuid < ActiveRecord::Migration[6.1]
  def up
    execute "ALTER TABLE loans ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE loans ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
