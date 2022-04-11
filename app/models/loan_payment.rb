# frozen_string_literal: true

class LoanPayment < ApplicationRecord
  INTEREST_RULE = ['reducing balance', 'fixed rate', 'per month', 'per annum', 'per day'].freeze
  class << self
    def initiate_payment(params)
      loan = Loan.find(params[:loan_payment]['loan_id'])
      product = Loancategory.find(loan.loan_type)

      {
        rules: INTEREST_RULE,
        rule: product.interest_rule,
        list: INTEREST_RULE.filter { |i| i == product.interest_rule },
        found: INTEREST_RULE.filter { |i| i == product.interest_rule }.size.zero?
      }

      return unless INTEREST_RULE.filter { |i| i == product.interest_rule }.size.positive?

      pick_calculator(product.interest_rule, loan, params, product)
    end

    def pick_calculator(interest_rule, loan, params, product)
      user = User.find(params[:loan_payment]['user_id'])
      group = Group.find(params[:loan_payment]['group_id'])
      member = Member.find_by(user_id: params[:loan_payment]['user_id'])

      case interest_rule
      when 'reducing balance'
        reducing_balance(loan, product, group, user, params)
      when 'fixed rate'
        fixed_rate(loan, product, group, user, params)
      when 'per month'
        per_month(loan, product, group, user, params)
      when 'per annum'
        per_annum(loan, product, group, user, params)
      when 'per day'
        per_day(loan, product, group, user, params)
      end
    end

    def reducing_balance(loan, product, _group, _user, params)
      interest = product.interest.to_f / 100
      amount = loan.amount.to_f
      amount_due = loan.amount_due.to_f
      amount_paid =  params[:loan_payment]['amount'].to_f
      new_amount_due = (amount_due.to_f - amount_paid.to_f)
      with_reducing_balance = new_amount_due.to_f + (new_amount_due.to_f * interest)

      {
        interest: interest,
        amount: amount.to_f,
        amount_due: amount_due.to_f,
        amount_paid: amount_paid.to_f,
        new_amount_due: new_amount_due.to_f,
        with_reducing_balance: with_reducing_balance.to_f
      }
    end

    def fixed_rate(loan, product, _group, _user, params)
      interest = product.interest.to_f / 100
      amount = loan.amount.to_f
      amount_due = loan.amount_due.to_f
      amount_paid =  params[:loan_payment]['amount'].to_f
      new_amount_due = (amount_due.to_f - amount_paid.to_f)

      {
        interest: interest,
        amount: amount.to_f,
        amount_due: amount_due.to_f,
        amount_paid: amount_paid.to_f,
        new_amount_due: new_amount_due.to_f
      }
    end

    def per_month(loan, _product, _group, _user, _params)
      last_payment = LoanPayment.where(loan_id: loan.id).order(created_at: :DESC).first
      last_pay_day = last_payment.present? ? last_payment.created_at : loan.created_at
      today = Date.today
      months_between = (today.year - last_pay_day.year) * 12 + today.month - last_pay_day.month - (today.day >= last_pay_day.day ? 0 : 1)

      {
        last_payment: last_payment,
        last_pay_day: last_pay_day,
        today: today,
        months_between: months_between
      }
    end

    def per_annum(loan, product, group, user, params); end
    def per_day(loan, product, group, user, params); end
  end
end
