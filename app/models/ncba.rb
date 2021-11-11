# frozen_string_literal: true

class Ncba < ApplicationRecord
  class << self
    def hash_value(secret, trans_type, trans_id, trans_time, trans_amount, account_number, narrative, phone_number, customer_name, status)
      unhashed = "#{secret}#{trans_type}#{trans_id}#{trans_time}#{trans_amount}#{account_number}#{narrative}#{phone_number}#{customer_name}#{status}"
      Base64.encode64(OpenSSL::HMAC.hexdigest('sha256', secret, unhashed))
    end
  end
end
