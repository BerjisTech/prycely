# frozen_string_literal: true

json.extract! member, :id, :invited_by, :user_id, :group_id, :designation, :status, :invited_on, :accepted_on,
              :paid_member, :amount, :created_at, :updated_at
json.url member_url(member, format: :json)
