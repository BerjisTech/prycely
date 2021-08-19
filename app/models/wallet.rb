# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :user

  def self.mine(user_id)
    Wallet.where(user_id: user_id)
  end

  def self.dashboard_colors
    colors = []
    colors << ["FDEDEE","E14141"]
    colors << ["D8F6F0","52DFB4"]
    colors << ["D0E7FF","0147F3"]
    colors << ["F9F5E6","F2BD42"]
  end
end
