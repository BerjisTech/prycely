# frozen_string_literal: true

# Errors model
class Error < ApplicationRecord
    def self.add_error(method, error, referer, message)
        Error.create(
          method: 'stk_callback',
          error: params,
          time: DateTime.now,
          referer: request.referer,
          message: message
        )
    end
end
