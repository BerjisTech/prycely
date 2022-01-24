class ChangeGroupIdReferences < ActiveRecord::Migration[6.1]
  def change
     # ASSETS TABLES
     execute "ALTER TABLE group_assets ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
     execute "ALTER TABLE group_assets ALTER COLUMN added_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(added_by),'-',''), 32, '0')));"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
