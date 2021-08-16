# frozen_string_literal: true

json.array! @paybills, partial: "paybills/paybill", as: :paybill
