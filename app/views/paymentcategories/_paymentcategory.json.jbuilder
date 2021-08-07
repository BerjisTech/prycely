# frozen_string_literal: true

json.extract! paymentcategory, :id, :group_id, :created_by, :payment_category_type, :name, :created_at, :updated_at
json.url paymentcategory_url(paymentcategory, format: :json)
