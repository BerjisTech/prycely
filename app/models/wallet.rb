# frozen_string_literal: true

class Wallet < ApplicationRecord
  belongs_to :user

  def self.mine(user_id)
    Wallet.where(user_id: user_id)
  end
end
