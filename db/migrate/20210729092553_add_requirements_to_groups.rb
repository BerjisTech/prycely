# frozen_string_literal: true

class AddRequirementsToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :requirements, :text
  end
end
