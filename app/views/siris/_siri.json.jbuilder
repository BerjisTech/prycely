# frozen_string_literal: true

json.extract! siri, :id, :name, :value, :created_at, :updated_at
json.url siri_url(siri, format: :json)
