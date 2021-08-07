# frozen_string_literal: true

json.extract! redeem, :id, :invite_id, :created_at, :updated_at
json.url redeem_url(redeem, format: :json)
