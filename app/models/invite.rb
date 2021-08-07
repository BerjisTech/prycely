# frozen_string_literal: true

class Invite < ApplicationRecord
  has_many :redeems
  belongs_to :group
  belongs_to :user
end
