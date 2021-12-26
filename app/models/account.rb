# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user
  has_many :members
  has_one_attached :image, dependent: :destroy

  def self.mine(user_id)
    Account.find_by(user_id: user_id)
  end

  def self.join_member_details(invite_user_id, user_id, group_id, account_id)
    Member.create(
      invited_by: invite_user_id,
      user_id: user_id,
      group_id: group_id,
      designation: 'member',
      status: '1',
      invited_on: DateTime.now,
      accepted_on: DateTime.now,
      paid_member: '',
      amount: 0,
      account_id: account_id
    )
  end

  def self.redeem_member_details(invite_id, user_id, group_id)
    Redeem.create(
      invite_id: invite_id,
      user_id: user_id,
      group_id: group_id,
      complete: 1
    )
  end

  def self.full_names(user_id)
    account = Account.find_by(user_id: user_id)
    if account.present?
      "#{account.first_name.humanize} #{account.last_name.humanize}"
    else
      "-- --"
    end
  end
end
