# frozen_string_literal: true

class AddMessageToErrors < ActiveRecord::Migration[6.1]
  def change
    add_column :errors, :message, :text
  end
end
