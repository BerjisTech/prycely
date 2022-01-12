# frozen_string_literal: true

class Loan < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_rich_text :requirements
end
