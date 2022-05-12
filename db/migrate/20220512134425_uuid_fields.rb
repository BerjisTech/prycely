# frozen_string_literal: true

class UuidFields < ActiveRecord::Migration[6.1]
  def change
    execute "ALTER TABLE paymentcategories ALTER COLUMN group_id SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_id),'-',''), 32, '0')));"
    execute "ALTER TABLE paymentcategories ALTER COLUMN created_by SET DATA TYPE UUID USING (uuid(lpad(replace(text(created_by),'-',''), 32, '0')));"
    execute "ALTER TABLE transactions ALTER COLUMN category SET DATA TYPE UUID USING (uuid(lpad(replace(text(category),'-',''), 32, '0')));"
  end
end
