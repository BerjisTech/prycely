# frozen_string_literal: true

require "application_system_test_case"

class StksTest < ApplicationSystemTestCase
  setup do
    @stk = stks(:one)
  end

  test "visiting the index" do
    visit stks_url
    assert_selector "h1", text: "Stks"
  end

  test "creating a Stk" do
    visit stks_url
    click_on "New Stk"

    fill_in "Checkout request", with: @stk.checkout_request_id
    fill_in "Custom message", with: @stk.custom_message
    fill_in "Merchant request", with: @stk.merchant_request_id
    fill_in "Phone", with: @stk.phone
    fill_in "Response code", with: @stk.response_code
    fill_in "Response description", with: @stk.response_description
    fill_in "Response result code", with: @stk.response_result_code
    fill_in "Response result description", with: @stk.response_result_description
    fill_in "Status", with: @stk.status
    fill_in "Transaction reference", with: @stk.transaction_reference
    click_on "Create Stk"

    assert_text "Stk was successfully created"
    click_on "Back"
  end

  test "updating a Stk" do
    visit stks_url
    click_on "Edit", match: :first

    fill_in "Checkout request", with: @stk.checkout_request_id
    fill_in "Custom message", with: @stk.custom_message
    fill_in "Merchant request", with: @stk.merchant_request_id
    fill_in "Phone", with: @stk.phone
    fill_in "Response code", with: @stk.response_code
    fill_in "Response description", with: @stk.response_description
    fill_in "Response result code", with: @stk.response_result_code
    fill_in "Response result description", with: @stk.response_result_description
    fill_in "Status", with: @stk.status
    fill_in "Transaction reference", with: @stk.transaction_reference
    click_on "Update Stk"

    assert_text "Stk was successfully updated"
    click_on "Back"
  end

  test "destroying a Stk" do
    visit stks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stk was successfully destroyed"
  end
end
