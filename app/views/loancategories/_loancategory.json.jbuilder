# frozen_string_literal: true

json.extract! loancategory, :id, :group_id, :created_by, :name, :period, :decsription, :pegged_to, :amount, :interest,
              :interest_rule, :required_guarantos, :membership_durantion_requirement, :requirements, :approvals, :created_at, :updated_at
json.url loancategory_url(loancategory, format: :json)
