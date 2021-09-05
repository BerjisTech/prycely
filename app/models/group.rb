# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :members
  has_many :loans
  has_many :loancategories
  has_many :projects
  has_many :transactions
  has_many :paymentcategories
  has_many :assets
  has_many :liabilities
  has_many :activities
  has_many :invites
  has_many :redeems
  has_many :logs

  def self.credit(group_id)
    Transaction.where(group_id: group_id).where(transaction_type: 1).pluck('sum(amount)').first || 0
  end

  def self.debit(group_id)
    Transaction.where(group_id: group_id).where(transaction_type: 2).pluck('sum(amount)').first || 0
  end

  def self.balance(group_id)
    credit(group_id) - debit(group_id)
  end

  def self.mine(user_id, limit = 10, offset = 0)
    Member.limit(limit).offset(offset).order(created_at: :desc).where.not(status: '0').where(user_id: user_id).joins(:group).select_my_group_data
  end

  def self.me(user_id, group_id)
    Member.find_by(user_id: user_id, group_id: group_id)
  end
end
