# frozen_string_literal: true

class AddProjectIdToLiabilities < ActiveRecord::Migration[6.1]
  def change
    add_column :liabilities, :project_id, :uuid
  end
end
