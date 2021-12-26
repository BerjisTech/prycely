# frozen_string_literal: true

module GroupsHelper
  def transactions(group_id, date_start, date_end)
    Transaction.where(group_id: group_id, level: 1,
                      status: 1).where(created_at: date_start..date_end).select('sum(CASE WHEN transaction_type = 1 THEN amount ELSE 0 END) as credit, sum(CASE WHEN transaction_type = 2 THEN amount ELSE 0 END) as debit, currency, DATE(created_at) as date').group('date, currency')
  end
end
