# frozen_string_literal: true

class AddPeggedToToLoancategories < ActiveRecord::Migration[6.1]
  def change
    add_column :loancategories, :pegged_to, :string
  end
end
