# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_email(from, to, subject)
    headers['X-MJ-CustomID'] = 'custom value'
    headers['X-MJ-EventPayload'] = 'custom payload'

    mail(
      from: from,
      to: to,
      subject: subject
    )
  end

  def invite_email(from, to, subject)
    headers['X-MJ-CustomID'] = 'custom value'
    headers['X-MJ-EventPayload'] = 'custom payload'

    mail(
      from: from,
      to: to,
      subject: subject
    )
  end

  def deregister_email(from, to, subject)
    headers['X-MJ-CustomID'] = 'custom value'
    headers['X-MJ-EventPayload'] = 'custom payload'

    mail(
      from: from,
      to: to,
      subject: subject
    )
  end

  def new_group_email(from, to, subject)
    headers['X-MJ-CustomID'] = 'custom value'
    headers['X-MJ-EventPayload'] = 'custom payload'

    mail(
      from: from,
      to: to,
      subject: subject
    )
  end
end
