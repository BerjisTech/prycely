# frozen_string_literal: true

class Loan < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_rich_text :requirements

  class << self
    def status(status)
      if status == 0
        'Pending'
        elsif status == 1
          'Approved'
        elsif status == 2
          'Declined'
        else
          'N/A'
        end
    end

    def guarantors(guarantors)
      guarantors.include? ','
    end
  end
end
