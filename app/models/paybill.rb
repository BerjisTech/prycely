# frozen_string_literal: true

class Paybill < ApplicationRecord
  def self.process_paybill_response(response)

    paybill_details = {
      transactionType: response['TransactionType'],
      mpesaCode: response['TransID'],
      payBillBalance: response['OrgAccountBalance'],
      thirdPartyTransID: response['ThirdPartyTransID'],
      invoiceNumber: response['InvoiceNumber'],
      amount: response['TransAmount'],
      firstName: response['FirstName'] || '',
      lastName: response['LastName'] || '',
      middleName: response['MiddleName'] || '',
      phone: response['MSISDN'],
      shortCode: response['BusinessShortCode'],
      accountNumber: response['BillRefNumber'].upcase
    }

    create_deposit(paybill_details, response)
    create_or_update_transaction(paybill_details, response)
  end

  def self.create_deposit(paybill_details, response)
    paybill_data = Paybill.new(
      'request': response,
      'paybill_type': paybill_details.transactionType,
      'transaction_reference': paybill_details.mpesaCode,
      'paybill_balance': paybill_details.payBillBalance,
      'third_party_transaction_id': paybill_details.thirdPartyTransID,
      'invoice_number': paybill_details.invoiceNumber,
      'amount': paybill_details.amount,
      'first_name': paybill_details.firstName,
      'last_name': paybill_details.lastName,
      'middle_name': paybill_details.middleName,
      'phone': paybill_details.phone,
      'short_code': paybill_details.shortCode,
      'account_number': paybill_details.accountNumber
    )
    begin
      paybill_data.save
    rescue StandardError
      Rollbar.error(paybill_data.errors)
    end
  end

  def self.create_or_update_transaction(paybill_details, _response)
    check_trans = Transaction.find_by(transaction_reference: 'refererefe')

    Transaction.update_paybill_tansaction(paybill_details.mpesaCode, paybill_details.amount) if check_trans.present?
  end

  def self.update_deposit; end

  def self.create_withdraw; end

  def self.update_withdraw; end
end
