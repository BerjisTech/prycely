# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user
  has_many :members
  has_one_attached :image, dependent: :destroy

  def self.mine(user_id)
    Account.find_by(user_id: user_id)
  end
end
