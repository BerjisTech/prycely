# frozen_string_literal: true

class Request < ApplicationRecord
  class << self
    def mine(user_id)
      where(user_id: user_id).select('emai as email', :user_id, :group_id, :accept)
    end
  end
end
