# frozen_string_literal: true

require "test_helper"

class StksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stk = stks(:one)
  end

  test "should get index" do
    get stks_url
    assert_response :success
  end

  test "should get new" do
    get new_stk_url
    assert_response :success
  end

  test "should create stk" do
    assert_difference("Stk.count") do
      post stks_url,
           params: { stk: { checkout_request_id: @stk.checkout_request_id, custom_message: @stk.custom_message,
                           merchant_request_id: @stk.merchant_request_id, phone: @stk.phone, response_code: @stk.response_code, response_description: @stk.response_description, response_result_code: @stk.response_result_code, response_result_description: @stk.response_result_description, status: @stk.status, transaction_reference: @stk.transaction_reference } }
    end

    assert_redirected_to stk_url(Stk.last)
  end

  test "should show stk" do
    get stk_url(@stk)
    assert_response :success
  end

  test "should get edit" do
    get edit_stk_url(@stk)
    assert_response :success
  end

  test "should update stk" do
    patch stk_url(@stk),
          params: { stk: { checkout_request_id: @stk.checkout_request_id, custom_message: @stk.custom_message,
                          merchant_request_id: @stk.merchant_request_id, phone: @stk.phone, response_code: @stk.response_code, response_description: @stk.response_description, response_result_code: @stk.response_result_code, response_result_description: @stk.response_result_description, status: @stk.status, transaction_reference: @stk.transaction_reference } }
    assert_redirected_to stk_url(@stk)
  end

  test "should destroy stk" do
    assert_difference("Stk.count", -1) do
      delete stk_url(@stk)
    end

    assert_redirected_to stks_url
  end
end
