# frozen_string_literal: true

json.array! @liabilities, partial: "liabilities/liability", as: :liability
