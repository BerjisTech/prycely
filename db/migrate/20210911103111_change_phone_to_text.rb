# frozen_string_literal: true

class ChangePhoneToText < ActiveRecord::Migration[6.1]
  def change
    change_column :stks, :phone, :text
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
