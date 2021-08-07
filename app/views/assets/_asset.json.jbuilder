# frozen_string_literal: true

json.extract! asset, :id, :name, :description, :group_id, :date_bought, :date_sold, :added_by, :price, :created_at,
              :updated_at
json.url asset_url(asset, format: :json)
