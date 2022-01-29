# frozen_string_literal: true

class Dashboard < ApplicationRecord
  class << self
    def dates
      today = Date.today
      last_month = (today - 30)
      dates = {
        today: today.strftime('%B %e, %Y'),
        last_month: last_month.strftime('%B %e, %Y')
      }
      OpenStruct.new dates
    end

    def recent_transactions(user_id)
      Transaction.where(user_id: user_id, status: 1)
                 .order(date: :asc)
                 .limit(30)
                 .offset(0)
                 .select('sum(CASE WHEN transaction_type = 1 THEN amount ELSE 0 END) as credit, sum(CASE WHEN transaction_type = 2 THEN amount ELSE 0 END) as debit, currency, DATE(created_at) as date')
                 .group('date, currency')
    end

    def group_numbers(user_id)
      my_transactions = Transaction.where(user_id: user_id).where(level: 1, status: 1)

      credit, debit, loan = 0

      my_transactions.map do |trans|
        if trans.transaction_type == 1
          credit += Currency.calculate_and_convert(Currency.amount_from_cents(trans.amount.to_f), trans.currency.upcase,
                                                   Account.find_by_user_id(user_id).default_currency.upcase)
        end
        if trans.transaction_type == 2
          debit += Currency.calculate_and_convert(Currency.amount_from_cents(trans.amount.to_f), trans.currency.upcase,
                                                  Account.find_by_user_id(user_id).default_currency.upcase)
        end
        if trans.transaction_type == 3
          loan += Currency.calculate_and_convert(Currency.amount_from_cents(trans.amount.to_f), trans.currency.upcase,
                                                 Account.find_by_user_id(user_id).default_currency.upcase)
        end
      end

      {
        credit: credit,
        debit: debit,
        loan: loan
      }
    end

    def my_group_savings(my_groups, user_id)
      group_data = []
      my_groups.map do |group|
        group_data << {
          name: group.name,
          savings: Group.user_savings(user_id, group.id)
        }
      end
      group_data
    end
end
end
