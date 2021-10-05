# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :members
  has_many :loans
  has_many :loancategories
  has_many :projects
  # has_many :transactions
  has_many :paymentcategories
  has_many :assets
  has_many :liabilities
  has_many :activities
  has_many :invites
  has_many :redeems
  has_many :logs

  scope :complete, -> { where(status: 1) }
  scope :money_in, -> { where(transaction_type: 1) }
  scope :money_out, -> { where(transaction_type: 2) }
  scope :select_my_group_data, lambda {
    select('members.id', 'groups.id', :name, :membership, :created_by, :group_id, :currency, :group_type)
  }

  def self.credit(group_id)
    Transaction.where(group_id: group_id, level: 1, transaction_type: 1, status: 1).pluck('sum(amount)').first.to_f
  end

  def self.debit(group_id)
    Transaction.where(group_id: group_id, level: 1, transaction_type: 2, status: 1).pluck('sum(amount)').first.to_f
  end

  def self.user_credit(group_id, user_id)
    Transaction.where(group_id: group_id, transaction_type: 1, level: 1, user_id: user_id,
                      status: 1).pluck('sum(amount)').first.to_f
  end

  def self.user_debit(group_id, user_id)
    Transaction.where(group_id: group_id, transaction_type: 2, level: 1, user_id: user_id,
                      status: 1).pluck('sum(amount)').first.to_f
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

  def self.user_savings(user_id, group_id)
    user_credit(group_id, user_id) - user_debit(group_id, user_id)
  end
end
