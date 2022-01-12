# frozen_string_literal: true

class AddMembershipDurantionRequirementToLoancategories < ActiveRecord::Migration[6.1]
  def change
    add_column :loancategories, :membership_durantion_requirement, :integer
  end
end
