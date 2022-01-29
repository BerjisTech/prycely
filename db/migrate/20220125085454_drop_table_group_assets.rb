# frozen_string_literal: true

class DropTableGroupAssets < ActiveRecord::Migration[6.1]
  def change
    drop_table :group_assets
  end
end
