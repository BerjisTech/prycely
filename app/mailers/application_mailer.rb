# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "prycely@gmail.com"
  layout "mailer"
end
