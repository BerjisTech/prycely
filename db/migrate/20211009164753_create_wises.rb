# frozen_string_literal: true

class CreateWises < ActiveRecord::Migration[6.1]
  def change
    create_table :wises, id: :uuid, &:timestamps
  end
end
