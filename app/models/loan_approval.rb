# frozen_string_literal: true

class LoanApproval < ApplicationRecord
  class << self
    def i_approved(loan, user_id, loan_type)
      if LoanApproval.where(loan_id: loan, user_id: user_id).present?
        true
      else
        LoanApproval.where(loan_id: loan).count >= Loancategory.find(loan_type).approvals
      end
    end
  end
end
