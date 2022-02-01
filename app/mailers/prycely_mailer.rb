# frozen_string_literal: true

class PrycelyMailer < ApplicationMailer
  def welcome_email(from, to, subject, user)
    headers['X-MJ-CustomID'] = 'custom value'
    headers['X-MJ-EventPayload'] = 'custom payload'

    @user = user
    mail(
      from: from,
      to: to,
      subject: subject
    )
  end

  def invite_email(from, to, subject, user, group)
    @user = user
    @group = group
    headers['X-MJ-CustomID'] = 'custom value'
    headers['X-MJ-EventPayload'] = 'custom payload'

    mail(
      from: from,
      to: to,
      subject: subject
    )
  end

  def deregister_email(from, to, subject, user, group)
    @user = user
    @group = group
    headers['X-MJ-CustomID'] = 'custom value'
    headers['X-MJ-EventPayload'] = 'custom payload'

    mail(
      from: from,
      to: to,
      subject: subject
    )
  end

  def new_group_email(from, to, subject, user, group)
    @user = user
    @group = group

    headers['X-MJ-CustomID'] = 'custom value'
    headers['X-MJ-EventPayload'] = 'custom payload'

    mail(
      from: from,
      to: to,
      subject: subject
    )
  end

  def new_approval_email(from, to, subject, user, loan)
    @user = user
    @loan = loan
    headers['X-MJ-CustomID'] = 'custom value'
    headers['X-MJ-EventPayload'] = 'custom payload'

    mail(
      from: from,
      to: to,
      subject: subject
    )
  end

  def loan_approved_email(from, to, subject, user, loan)
    @user = user
    @loan = loan
    headers['X-MJ-CustomID'] = 'custom value'
    headers['X-MJ-EventPayload'] = 'custom payload'

    mail(
      from: from,
      to: to,
      subject: subject
    )
  end
end
