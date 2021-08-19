# frozen_string_literal: true

json.array! @paymentcategories, partial: 'paymentcategories/paymentcategory', as: :paymentcategory
