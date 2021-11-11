# frozen_string_literal: true

class CreateNcbas < ActiveRecord::Migration[6.1]
  def change
    create_table :ncbas, id: :uuid, &:timestamps
  end
end
