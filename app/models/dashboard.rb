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

    def my_group_savings(user_id)
      group_data = []
      Group.mine(user_id).map do |group|
        group_data << {
          name: group.name,
          savings: Group.user_savings(user_id, group.id)
        }
      end
      group_data
    end

    def load(data_set, user_id)
      case data_set
      when 'groups'
        Group.mine(user_id)
      when 'wallets'
        Wallet.mine(user_id)
      when 'invites'
        Invite.mine(user_id)
      when 'requests'
        Request.mine(user_id)
      end
    end
  end
end
