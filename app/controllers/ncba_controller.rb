# frozen_string_literal: true

class NcbaController < ApplicationController
  before_action :initiate_ncba

  NO_PARAMS_ERROR = { error: 'Kindly pass all required parameters' }.freeze

  def account_opening
    account = @ncba_client.account_opening(
      uid: '',
      customer_category: 'customer',
      business_name: 'Prycely',
      prefered_name: 'Prycely',
      street: 'Nairobi',
      town_country: 'Nairobi-Kenya',
      country: 'Kenya',
      sector: 'Finance',
      industry: 'Information Technology',
      nationality: 'Kenya',
      email: 'berjistechnologies@gmail.com',
      emergency_email: 'berjistechnologies@gmail.com',
      phone_number: '+254725227513',
      building: '1',
      website: 'https://prycely.com',
      bank_name: 'NCBA',
      branch: 'Mama Ngina',
      account_number: '1',
      bank_account_name: 'Prycely',
      account_currency: 'KSH',
      cba_account: '1',
      bank_code: '1',
      swift_code: '1',
      business_phone_number: '+254725227513',
      postal_code: '271',
      postal_address: '00520',
      stakeholder_director_shareholder: '1',
      stakeholder_surname: 'Ouma',
      stakeholder_forename: 'Benedict',
      stakeholder_salutation: 'Mr',
      stakeholder_gender: 'Male',
      stakeholder_email: 'bo.kouru@gmail.com',
      stakeholder_phone: '+254725227513',
      stakeholder_postal_address: '271',
      stakeholder_town: 'Nairobi',
      stakeholder_postal_code: '00520',
      stakeholder_country: 'Kenya',
      stakeholder_id_type: 'national',
      stakeholder_id_number: '32976441',
      brn: 'PVT-GYUAK9K'
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
      bank_code: '', # Bank Code (For ALL MWallets use 99), (For MPesa use 16 if RTGS), (For Pesalink 404)
      bank_swift_code: '',
      branch_code: '', # Branch code ( For ALL Mwallets use 002 )
      beneficiary_account_name: '',
      country: 'Kenya', # Kenya, Uganda, Tanzania (Case Sensitive)
      transaction_type: '', # Internal, Eft, RTGS, Pesalink, Mpesa, HalotelTz, AirtelTz, ZantelTz, TigoTz, VodacomTz
      reference: '',
      currency: '', # KES, TZS, UGX
      account: '', # 254XXXXXX (or your country code) for mobile, account number if bank
      amount: '',
      narration: '',
      transaction_date: '',
      validation_id: '', # Validation from mpesa_verification
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
