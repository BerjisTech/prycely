# frozen_string_literal: true

class Paymentcategory < ApplicationRecord
  belongs_to :group
  class << self
    def category_name
      %w[default income expense]
    end
  end
end
