# frozen_string_literal: true

class AwesomeMailer < ApplicationMailer
  def awesome_mail(user)
    mail(
      to: user.email,
      delivery_method_options: { api_key: 'your-api-key', secret_key: 'your-secret-key' }
    )
  end
end
