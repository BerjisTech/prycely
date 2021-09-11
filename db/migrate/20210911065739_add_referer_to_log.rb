# frozen_string_literal: true

class AddRefererToLog < ActiveRecord::Migration[6.1]
  def change
    add_column :logs, :referer, :text
  end
end
