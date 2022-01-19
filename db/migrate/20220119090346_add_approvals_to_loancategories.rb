# frozen_string_literal: true

class AddApprovalsToLoancategories < ActiveRecord::Migration[6.1]
  def change
    add_column :loancategories, :approvals, :integer, default: 4
  end
end
