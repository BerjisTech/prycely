# frozen_string_literal: true

class ChangeStkPhoneColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :stks, :phone, :string
  end
end
