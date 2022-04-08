# frozen_string_literal: true

class LoanPayment < ApplicationRecord
  class << self
    def calculate_balance; end

    def reducing_balance; end

    def fixed_balance; end
  end
end
