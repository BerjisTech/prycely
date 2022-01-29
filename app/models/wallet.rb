# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :user
  has_many :logs
  # has_many :transactions

  scope :complete, -> { where(status: 1) }
  scope :money_in, -> { where(transaction_type: 1) }
  scope :money_out, -> { where(transaction_type: 2) }

  class << self
    def mine(user_id, limit = 10, offset = 0)
      Wallet.limit(limit).offset(offset).order(created_at: :desc).where(user_id: user_id)
    end

    def dashboard_colors
      colors = []
      colors << %w[FDEDEE E14141]
      colors << %w[D8F6F0 52DFB4]
      colors << %w[D0E7FF 0147F3]
      colors << %w[F9F5E6 F2BD42]
    end
  end
end
