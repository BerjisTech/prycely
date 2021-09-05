# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :group
  belongs_to :wallet

  def self.for_group(group_id, limit = 0, offset = 0)
    Transaction.where(group_id: group_id).limit(limit).offset(offset)
  end

  def self.total(group_id)
    Transaction.where(group_id: group_id).pluck('count(id)').first
  end

  def self.create_from_stk(amount, response, user, description, category, account)
    Rollbar.info('Starting STK Transaction Save')

    transaction = Transaction.new(
      user_id: user,
      amount: amount,
      transaction_reference: response['MpesaReceiptNumber'],
      transaction_type: 1,
      group_id: account,
      wallet_id: account,
      status: 0,
      transaction_mode: 1,
      description: description,
      category: category,
      sub_category: ''
    )

    save_transaction(transaction)
  end

  def self.save_transaction(transaction)
    if transaction.save
      Rollbar.info('New Transaction saved')
    else
      Rollbar.error("A transaction could not be saved because #{transaction.errors.inspect}")
    end
  end
end
