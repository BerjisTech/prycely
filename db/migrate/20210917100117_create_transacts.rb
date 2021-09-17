# frozen_string_literal: true

class CreateTransacts < ActiveRecord::Migration[6.1]
  def change
    create_table :transacts, id: :uuid, &:timestamps
  end
end
