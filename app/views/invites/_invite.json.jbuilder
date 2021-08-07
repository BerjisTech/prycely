# frozen_string_literal: true

json.extract! invite, :id, :group_id, :invite_key, :max_redeem, :invite_email, :created_at, :updated_at
json.url invite_url(invite, format: :json)
