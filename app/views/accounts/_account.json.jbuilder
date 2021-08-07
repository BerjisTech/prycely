# frozen_string_literal: true

json.extract! account, :id, :user_id, :phone, :first_name, :last_name, :photo, :deactivated, :verified, :country,
              :county, :city, :street, :address, :postal, :account_type, :tour, :created_at, :updated_at
json.url account_url(account, format: :json)
