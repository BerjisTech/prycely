class ConvertAllIdToUuid < ActiveRecord::Migration[6.1]
  
  def up
    
    execute "ALTER TABLE accounts ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE accounts ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE accounts ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE activities ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE activities ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE activities ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE admins ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE admins ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE admins ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE assets ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE assets ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE assets ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE errors ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE errors ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE errors ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE groups ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE groups ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE groups ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE grouptypes ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE grouptypes ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE grouptypes ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE invites ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE invites ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE invites ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE liabilities ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE liabilities ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE liabilities ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE loancategories ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE loancategories ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE loancategories ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE loans ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE loans ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE loans ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE logins ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE logins ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE logins ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE logs ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE logs ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE logs ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE members ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE members ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE members ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE paybills ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE paybills ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE paybills ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE paymentcategories ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE paymentcategories ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE paymentcategories ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE projects ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE projects ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE projects ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE redeems ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE redeems ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE redeems ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE requests ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE requests ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE requests ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE siris ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE siris ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE siris ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE stks ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE stks ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE stks ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE transactions ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE transactions ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE transactions ALTER COLUMN id SET DEFAULT gen_random_uuid();"

    execute "ALTER TABLE wallets ALTER COLUMN id DROP DEFAULT;"
    execute "ALTER TABLE wallets ALTER COLUMN id SET DATA TYPE UUID USING (uuid(lpad(replace(text(id),'-',''), 32, '0')));"
    execute "ALTER TABLE wallets ALTER COLUMN id SET DEFAULT gen_random_uuid();"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
