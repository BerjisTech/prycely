# frozen_string_literal: true

class NcbaController < ApplicationController
  before_action :initiate_ncba

  NO_PARAMS_ERROR = { error: 'Kindly pass all required parameters' }.freeze

  def account_opening
    account = @ncba_client.account_opening(
      uid: Digest::SHA1.hexdigest([Time.now, rand].join),
      customer_category: '',
      business_name: 'Prycely',
      prefered_name: 'Prycely',
      street: '',
      town_country: '',
      country: '',
      sector: '',
      industry: '',
      nationality: 'Kenya',
      email: 'berjistechnologies@gmail.com',
      emergency_email: '',
      phone_number: '0725227513',
      building: '',
      website: '',
      bank_name: '',
      branch: '',
      account_number: '',
      bank_account_name: 'Prycely',
      account_currency: 'KSH',
      cba_account: '',
      bank_code: '',
      swift_code: '',
      business_phone_number: '',
      postal_code: '',
      postal_address: '',
      stakeholder_director_shareholder: '',
      stakeholder_surname: '',
      stakeholder_forename: '',
      stakeholder_salutation: '',
      stakeholder_gender: '',
      stakeholder_email: '',
      stakeholder_phone: '',
      stakeholder_postal_address: '',
      stakeholder_town: '',
      stakeholder_postal_code: '',
      stakeholder_country: '',
      stakeholder_id_type: '',
      stakeholder_id_number: 'PVT-GYUAK9K'
    )
    # message = account['Reference'] || account['Description']
    render json: account
  end

  def credit_details
    credit = @ncba_client.credit_details(
      bizpawa_id: '',
      turnover_ratio: '',
      saas_payment_rate: '',
      payment_mode_rate: '',
      predictive_analysis: '',
      prev_loan_repayment_rate: '',
      pre_existing_cba_account: '',
      customer_bizpawa_age: '',
      inventory_turnover: '',
      director_listed_crb: '',
      business_listed_crb: '',
      bank_code: ''
    )
    render json: credit
  end

  def credit_transfer
    transfer = @ncba_client.credit_transfer(
      bank_code: '',
      bank_swift_code: '',
      branch_code: '',
      beneficiary_account_name: '',
      country: '',
      transaction_type: '',
      reference: '',
      currency: '',
      account: '',
      amount: '',
      narration: '',
      transaction_date: '',
      validation_id: '',
      sender_name: '',
      purpose_of_payment: '',
      sender_principle_activity: '',
      sender_address: '',
      receiver_address: '',
      receiver_id: '',
      sender_id: '',
      beneficiary_name: ''
    )
    render json: transfer
  end

  def mpesa_verification
    phone = @ncba_client.mpesa_phone_number_validation(
      mobile_number: '0790494969',
      reference: 'reference'
    )
    
    render json: phone
  end

  def transaction_query
    transaction = @ncba_client.transaction_query(
      country: '',
      reference_number: ''
    )
    render json: transaction
  end

  def push_notif
    Ncba.hash_value(
      params[:secret],
      params[:trans_type],
      params[:trans_id],
      params[:trans_time],
      params[:trans_amount],
      params[:account_number],
      params[:narrative],
      params[:phone_number],
      params[:customer_name],
      params[:status]
    )

    render json: NO_PARAMS_ERROR
  end

  def call; end

  def initiate_ncba
    @ncba_client = Ncba::Client.new(
      api_user: 'berjis',
      api_key: 'ke123'
    )
  end
end
