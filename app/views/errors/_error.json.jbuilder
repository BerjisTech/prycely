# frozen_string_literal: true

json.extract! error, :id, :error, :time, :created_at, :updated_at
json.url error_url(error, format: :json)
