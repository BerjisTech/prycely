# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :group
  has_rich_text :host_contact
  has_rich_text :description
end
