# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :user

  def self.mine(user_id)
    Wallet.where(user_id: user_id)
  end

  def self.dashboard_colors
    colors = []
    colors << %w[FDEDEE E14141]
    colors << %w[D8F6F0 52DFB4]
    colors << %w[D0E7FF 0147F3]
    colors << %w[F9F5E6 F2BD42]
  end
end
