# frozen_string_literal: true

class Paybill < ApplicationRecord
  def self.process_paybill_response(response)
    # paybill_details = {
    #   transactionType: response['TransactionType'],
    #   mpesaCode: response['TransID'],
    #   payBillBalance: response['OrgAccountBalance'],
    #   thirdPartyTransID: response['ThirdPartyTransID'],
    #   invoiceNumber: response['InvoiceNumber'],
    #   amount: response['InvoiceNumber'],
    #   firstName: response['FirstName'] || '',
    #   lastName: response['LastName'] || '',
    #   middleName: response['MiddleName'] || '',
    #   phone: response['MSISDN'],
    #   shortCode: response['BusinessShortCode'],
    #   accountNumber: response['BillRefNumber'].upcase
    # }

    create_deposit(response)
    create_or_update_transaction(response)
  end

  def self.create_deposit(response)
    paybill_data = Paybill.new(
      'request': response,
      'paybill_type': response['TransactionType'],
      'transaction_reference': response['TransID'],
      'paybill_balance': response['OrgAccountBalance'],
      'third_party_transaction_id': response['ThirdPartyTransID'],
      'invoice_number': response['InvoiceNumber'],
      'amount': response['TransAmount'].to_f,
      'first_name': response['FirstName'],
      'last_name': response['LastName'],
      'middle_name': response['MiddleName'],
      'phone': response['MSISDN'],
      'short_code': response['BusinessShortCode'],
      'account_number': response['BillRefNumber'].upcase
    )
    begin
      paybill_data.save
    rescue StandardError
      Rollbar.error(paybill_data.errors)
    end
  end

  def self.create_or_update_transaction(response)
    check_trans = Transaction.find_by(transaction_reference: response['TransID'])

    if check_trans.present?
      Transaction.update_paybill_tansaction(response['TransID'], response['TransAmount'].to_f)
    else
      Transaction.create_from_paybill(response['TransID'], response['TransAmount'].to_f)
    end
  end

  def self.update_deposit; end

  def self.create_withdraw; end

  def self.update_withdraw; end
end
