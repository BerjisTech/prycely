# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :group
  belongs_to :wallet
end
