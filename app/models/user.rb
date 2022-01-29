# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :registerable, :confirmable

  has_many :wallets
  has_many :groups
  has_many :transactions
  has_many :loans
  has_many :logins
  has_many :accounts
  has_many :members
  has_many :redeems
  has_many :invites
  has_many :logs

  # protected

  # def confirmation_required?
  #   false
  # end
  class << self
    def range_credit(user_id, _start_date, _range)
      amount = 0
      Transaction
        .where(user_id: user_id, transaction_type: 1, status: 1)
        .where.not(level: nil, group_id: nil, wallet_id: nil, currency: nil)
        .all.map do |transaction|
        amount += Currency.calculate_and_convert(Currency.amount_from_cents(transaction.amount.to_f),
                                                 transaction.currency.upcase, Account.find_by_user_id(user_id).default_currency.upcase)
        p "#{transaction.amount} converted to a sum of #{amount}"
      end
      amount
    end

    def range_debit(user_id, _start_date, _range)
      amount = 0
      Transaction
        .where(user_id: user_id, transaction_type: 2, status: 1)
        .where.not(level: nil, group_id: nil, wallet_id: nil, currency: nil)
        .all.map do |transaction|
        amount += Currency.calculate_and_convert(Currency.amount_from_cents(transaction.amount.to_f),
                                                 transaction.currency.upcase, Account.find_by_user_id(user_id).default_currency.upcase)
        p "#{transaction.amount} converted to a sum of #{amount}"
      end
      amount
    end

    def range_savings(user_id, start_date, range)
      range_credit(user_id, start_date, range) - range_debit(user_id, start_date, range)
    end

    def loans(_user_id)
      {
        requested: 0,
        received: 0,
        paid: 0
      }
    end

    def is_in_system(user)
      if User.find_by(email: user).nil?
        false
      else
        true
      end
    end
  end
end
