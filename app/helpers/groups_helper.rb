# frozen_string_literal: true

module GroupsHelper
  def graph_transactions(group_id, from, to)
    date_start = Date.today - from.to_i.days
    date_end = Date.today - to.to_i.days
    Transaction.where(group_id: group_id, level: 1, status: 1)
               .where(created_at: date_start..date_end)
               .select('sum(CASE WHEN transaction_type = 1 THEN amount ELSE 0 END) as credit, sum(CASE WHEN transaction_type = 2 THEN amount ELSE 0 END) as debit, currency, DATE(created_at) as date')
               .group('date, currency')
  end
end
