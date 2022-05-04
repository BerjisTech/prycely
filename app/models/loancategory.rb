# frozen_string_literal: true

class Loancategory < ApplicationRecord
  belongs_to :group
  has_rich_text :decsription
  has_rich_text :requirements

  class << self
    def get_date_due(date_taken, loan_category)
      loan_category_duration = Loancategory.find(loan_category).period.to_i
      date_taken + loan_category_duration.months
    end

    def calculate_total_with_interest(amount, loan_category_id)
      loan_category = Loancategory.find(loan_category_id)
      interest = loan_category.interest.to_f
      interest_rule = loan_category.interest_rule
      duration = loan_category.period

      case interest_rule
      when 'fixed rate'
        get_fixed_interest(amount, interest)
      when 'per annum'
        get_pa_interest(amount, interest, duration)
      when 'per month'
        get_pm_interest(amount, interest, duration)
      when 'per day'
        get_pd_interest(amount, interest, duration)
      when 'reducing balance'
        get_rb_interest(amount, interest)
      end
    end

    def get_fixed_interest(amount, interest)
      ((interest / 100) * amount)
    end

    def get_pa_interest(balance, interest, _duration)
      ((interest.to_f / 100) * balance)
    end

    def get_pd_interest(balance, interest, _duration)
      ((interest.to_f / 100) * balance)
    end

    def get_pm_interest(balance, interest, _duration)
      ((interest.to_f / 100) * balance)
    end

    def get_rb_interest(balance, interest)
      ((interest.to_f / 100) * balance)
    end
  end
end
