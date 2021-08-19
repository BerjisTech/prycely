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

  def self.mine(user_id)
    Member.where.not(status: '0').where(user_id: user_id).joins(:group).select_my_group_data
  end
end
