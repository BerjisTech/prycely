# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :group
  has_rich_text :description
end
