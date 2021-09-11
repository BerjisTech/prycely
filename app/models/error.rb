# frozen_string_literal: true

# Errors model
class Error < ApplicationRecord
  def self.add_error(method, error, referer, message)
    Error.create(
      method: method,
      error: error,
      time: DateTime.now,
      referer: referer,
      message: message
    )
  end
end
