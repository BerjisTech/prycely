# frozen_string_literal: true

class Transaction < ApplicationRecord
  # belongs_to :group
  # belongs_to :wallet

  def self.for_group(group_id, limit = 0, offset = 0)
    Transaction.where(group_id: group_id).limit(limit).offset(offset)
  end

  def self.total(group_id)
    Transaction.where(group_id: group_id).pluck('count(id)').first
  end

  def self.create_from_stk(amount, response, user, description, level, account, currency)
    amount = amount * 100
    transaction = Transaction.new(
      user_id: user,
      amount: amount,
      transaction_reference: response['MerchantRequestID'],
      transaction_type: 1, # 1 deposit / 2 withdraw / 3 transfer / 4 send
      level: level, # 2 group/ 1 personal
      group_id: account,
      wallet_id: account,
      status: 0,
      transaction_mode: 1,
      description: description,
      category: 'category',
      currency: currency,
      sub_category: ''
    )

    save_transaction(transaction)
  end

  def self.create_from_paybill(mpesaCode, amount)
    amount = amount * 100
    transaction = Transaction.new(
      amount: amount,
      transaction_reference: mpesaCode,
      transaction_type: 1, # 1 deposit / 2 withdraw / 3 transfer / 4 send
      status: 0, # 0 pending / 1 success / 2 failed / 3 error
      transaction_mode: 1,
      user_id: 0,
      group_id: 0,
      wallet_id: 0,
      currency: 'KES'
    )
    save_transaction(transaction)
  end

  def self.update_success_transaction(merchantRequestID, mpesaReceiptNumber, statusRes)
    Transaction.where(transaction_reference: merchantRequestID).update_all(status: statusRes)
    Transaction.where(transaction_reference: mpesaReceiptNumber).update_all(status: statusRes)
  end

  def self.save_transaction(transaction)
    if transaction.save
      Rollbar.info('New Transaction saved')
    else
      Rollbar.error("A transaction could not be saved because #{transaction.errors.inspect}")
    end
  end

  def self.update_paybill_tansaction(mpesaCode, amount)
    amount = amount * 100
    transaction = {
      transaction_reference: mpesaCode,
      amount: amount,
      status: 1
    }

    begin
      Transaction.where(transaction_reference: mpesaCode).update_all(transaction)
    rescue StandardError
      Rollbar.error(transaction.errors)
    end

    Stk.update_pending_with_merchant_request_id(transaction)
  end
end