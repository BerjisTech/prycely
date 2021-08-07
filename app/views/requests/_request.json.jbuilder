# frozen_string_literal: true

json.extract! request, :id, :group_id, :user_id, :account_id, :emai, :accept, :created_at, :updated_at
json.url request_url(request, format: :json)
