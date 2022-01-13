# frozen_string_literal: true

class Loan < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_rich_text :requirements

  class << self
    def status(status)
      case status
      when 0
        'Pending'
      when 1
        'Approved'
      when 2
        'Declined'
      else
        'N/A'
      end
    end

    def guarantors(guarantors)
      guarantors.split(',')
    end

    def verify_guarantors(guarantors, requester)
      if guarantors.include? requester
        false
      else
        true
      end
    end
  end
end
