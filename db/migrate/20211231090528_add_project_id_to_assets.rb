# frozen_string_literal: true

class AddProjectIdToAssets < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :project_id, :uuid
  end
end
