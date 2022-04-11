# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :members
  has_many :loans
  has_many :loancategories
  has_many :projects
  # has_many :transactions
  has_many :paymentcategories
  has_many :group_assets
  has_many :liabilities
  has_many :activities
  has_many :invites
  has_many :redeems
  has_many :logs

  scope :complete, -> { where(status: 1) }
  scope :money_in, -> { where(transaction_type: 1) }
  scope :money_out, -> { where(transaction_type: 2) }

  class << self
    def credit(group_id)
      Transaction.where(group_id: group_id, level: 1, transaction_type: 1, status: 1).pluck('sum(amount)').first.to_f
    end

    def debit(group_id)
      Transaction.where(group_id: group_id, level: 1, transaction_type: 2, status: 1).pluck('sum(amount)').first.to_f
    end

    def user_credit(group_id, user_id)
      amount = 0
      Transaction
        .where(group_id: group_id, transaction_type: 1, level: 1, user_id: user_id, status: 1)
        .where.not(level: nil, group_id: nil, wallet_id: nil, currency: nil)
        .all.map do |transaction|
        amount += Currency.calculate_and_convert(Currency.amount_from_cents(transaction.amount.to_f),
                                                 transaction.currency.upcase, Account.find_by_user_id(user_id).default_currency.upcase)
        p "#{transaction.amount} converted to a sum of #{amount}"
      end
      amount
    end

    def user_debit(group_id, user_id)
      amount = 0
      Transaction
        .where(group_id: group_id, transaction_type: 2, level: 1, user_id: user_id, status: 1)
        .where.not(level: nil, group_id: nil, wallet_id: nil, currency: nil)
        .all.map do |transaction|
        amount += Currency.calculate_and_convert(Currency.amount_from_cents(transaction.amount.to_f),
                                                 transaction.currency.upcase, Account.find_by_user_id(user_id).default_currency.upcase)
        p "#{transaction.amount} converted to a sum of #{amount}"
      end
      amount
    end

    def balance(group_id)
      Money.new(credit(group_id) - debit(group_id))
    end

    def mine(user_id, limit = 10, offset = 0)
      Member.limit(limit).offset(offset).order(created_at: :desc).where.not(status: '0').where(user_id: user_id).joins(:group).select(
        'members.id', 'groups.id', :name, :accepted_on, :membership, :group_id, :created_by, :currency, :group_type
      )
    end

    def me(user_id, group_id)
      Member.find_by(user_id: user_id, group_id: group_id)
    end

    def user_savings(user_id, group_id)
      user_credit(group_id, user_id) - user_debit(group_id, user_id)
    end

    def graph_transactions(group_id, from, to, account)
      date_start = Time.now - from.to_i.days
      date_end = Time.now - to.to_i.days
      transactions = Transaction.where(group_id: group_id, level: 1, status: 1)
                                .where(created_at: date_start..date_end)
                                .select('sum(CASE WHEN transaction_type = 1 THEN amount ELSE 0 END) as credit, sum(CASE WHEN transaction_type = 2 THEN amount ELSE 0 END) as debit, currency, DATE(created_at) as date')
                                .order(date: :asc)
                                .group('date, currency')
      format_transaftions(transactions, account)
    end

    def format_transaftions(transactions, account)
      graph_data = {
        dates: [],
        debit: [],
        credit: []
      }
      transactions.map do |transaction|
        graph_data[:dates] << transaction.date.strftime('%Y-%m-%d')
        graph_data[:debit] << Currency.calculate_and_convert(Currency.amount_from_cents(transaction.debit).round(2),
                                                             transaction.currency.upcase, account.default_currency.upcase)
        graph_data[:credit] << Currency.calculate_and_convert(Currency.amount_from_cents(transaction.credit).round(2),
                                                              transaction.currency.upcase, account.default_currency.upcase)
      end
      graph_data
    end

    def table_transactions(group_id, from, to)
      date_start = Time.now - from.to_i.days
      date_end = Time.now - to.to_i.days
      Transaction.where(group_id: group_id, level: 1, status: 1)
                 .where(created_at: date_start..date_end)
                 .order(created_at: :desc)
                 .select('*')
    end
end
end
