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
      when 3
        'Defaulted'
      else
        'N/A'
      end
    end

    def guarantors(guarantors)
      guarantors.split(',')
    end

    def own_guarantor(guarantors, requester)
      if guarantors.include? requester
        1
      else
        0
      end
    end
  end
end
