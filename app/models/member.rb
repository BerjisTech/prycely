# frozen_string_literal: true

class Member < ApplicationRecord
  belongs_to :group
  belongs_to :user
  belongs_to :account
end
