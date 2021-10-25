# frozen_string_literal: true

class ChangeGroupTypeToUuid < ActiveRecord::Migration[6.1]
  def change
    execute "ALTER TABLE groups ALTER COLUMN group_type SET DATA TYPE UUID USING (uuid(lpad(replace(text(group_type),'-',''), 32, '0')));"
  end
end
