# frozen_string_literal: true

require "test_helper"

class PaybillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paybill = paybills(:one)
  end

  test "should get index" do
    get paybills_url
    assert_response :success
  end

  test "should get new" do
    get new_paybill_url
    assert_response :success
  end

  test "should create paybill" do
    assert_difference("Paybill.count") do
      post paybills_url,
           params: { paybill: { account_number: @paybill.account_number, amount: @paybill.amount, first_name: @paybill.first_name,
                               invoice_number: @paybill.invoice_number, last_name: @paybill.last_name, middle_name: @paybill.middle_name, paybill_balance: @paybill.paybill_balance, phone: @paybill.phone, request: @paybill.request, short_code: @paybill.short_code, third_party_transaction_id: @paybill.third_party_transaction_id, transaction_reference: @paybill.transaction_reference, type: @paybill.type } }
    end

    assert_redirected_to paybill_url(Paybill.last)
  end

  test "should show paybill" do
    get paybill_url(@paybill)
    assert_response :success
  end

  test "should get edit" do
    get edit_paybill_url(@paybill)
    assert_response :success
  end

  test "should update paybill" do
    patch paybill_url(@paybill),
          params: { paybill: { account_number: @paybill.account_number, amount: @paybill.amount, first_name: @paybill.first_name,
                              invoice_number: @paybill.invoice_number, last_name: @paybill.last_name, middle_name: @paybill.middle_name, paybill_balance: @paybill.paybill_balance, phone: @paybill.phone, request: @paybill.request, short_code: @paybill.short_code, third_party_transaction_id: @paybill.third_party_transaction_id, transaction_reference: @paybill.transaction_reference, type: @paybill.type } }
    assert_redirected_to paybill_url(@paybill)
  end

  test "should destroy paybill" do
    assert_difference("Paybill.count", -1) do
      delete paybill_url(@paybill)
    end

    assert_redirected_to paybills_url
  end
end
