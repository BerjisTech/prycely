# frozen_string_literal: true

class ChangeUserIdTypeToUuid < ActiveRecord::Migration[6.1]
  def up
    # ACCOUNTS TABLES
    execute "ALTER TABLE accounts ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"

    # ACTIVITIES TABLES
    execute "ALTER TABLE activities ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE activities ALTER COLUMN created_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(created_by),'-',''), 32, '0')));"

    # ASSETS TABLES
    execute "ALTER TABLE assets ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE assets ALTER COLUMN added_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(added_by),'-',''), 32, '0')));"

    # GROUPS TABLES
    execute "ALTER TABLE groups ALTER COLUMN created_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(created_by),'-',''), 32, '0')));"

    # INVITES TABLES
    execute "ALTER TABLE invites ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE invites ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"

    # LIABILITIES TABLES
    execute "ALTER TABLE liabilities ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE liabilities ALTER COLUMN added_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(added_by),'-',''), 32, '0')));"

    # loancategories TABLES
    execute "ALTER TABLE loancategories ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE loancategories ALTER COLUMN created_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(created_by),'-',''), 32, '0')));"

    # MEMBERS TABLES
    execute "ALTER TABLE members ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE members ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE members ALTER COLUMN invited_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(invited_by),'-',''), 32, '0')));"
    execute "ALTER TABLE members ALTER COLUMN account_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(account_id),'-',''), 32, '0')));"

    # PROJECTS TABLES
    execute "ALTER TABLE projects ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE projects ALTER COLUMN created_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(created_by),'-',''), 32, '0')));"

    # REDEEMS TABLES
    execute "ALTER TABLE redeems ALTER COLUMN invite_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(invite_id),'-',''), 32, '0')));"
    execute "ALTER TABLE redeems ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE redeems ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"

    # REQUESTS TABLES
    execute "ALTER TABLE requests ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE requests ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE requests ALTER COLUMN account_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(account_id),'-',''), 32, '0')));"

    # TRANSACTIONS TABLES
    execute "ALTER TABLE transactions ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
    execute "ALTER TABLE transactions ALTER COLUMN wallet_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(wallet_id),'-',''), 32, '0')));"
    execute "ALTER TABLE transactions ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"

    # WALLETS TABLES
    execute "ALTER TABLE wallets ALTER COLUMN user_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(user_id),'-',''), 32, '0')));"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
