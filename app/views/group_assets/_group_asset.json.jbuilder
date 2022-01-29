# frozen_string_literal: true

json.extract! group_asset, :id, :name, :description, :group_id, :date_bought, :date_sold, :user_id, :price,
              :created_at, :updated_at
json.url group_asset_url(group_asset, format: :json)
