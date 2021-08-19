# frozen_string_literal: true

class Invite < ApplicationRecord
  has_many :redeems
  belongs_to :group
  belongs_to :user

  def self.mine(user_id)
    Member.where(status: '0').where(user_id: user_id).joins(:group).select_for_invites
  end
end
