# frozen_string_literal: true

require "application_system_test_case"

class PaybillsTest < ApplicationSystemTestCase
  setup do
    @paybill = paybills(:one)
  end

  test "visiting the index" do
    visit paybills_url
    assert_selector "h1", text: "Paybills"
  end

  test "creating a Paybill" do
    visit paybills_url
    click_on "New Paybill"

    fill_in "Account number", with: @paybill.account_number
    fill_in "Amount", with: @paybill.amount
    fill_in "First name", with: @paybill.first_name
    fill_in "Invoice number", with: @paybill.invoice_number
    fill_in "Last name", with: @paybill.last_name
    fill_in "Middle name", with: @paybill.middle_name
    fill_in "Paybill balance", with: @paybill.paybill_balance
    fill_in "Phone", with: @paybill.phone
    fill_in "Request", with: @paybill.request
    fill_in "Short code", with: @paybill.short_code
    fill_in "Third party transaction", with: @paybill.third_party_transaction_id
    fill_in "Transaction reference", with: @paybill.transaction_reference
    fill_in "Type", with: @paybill.type
    click_on "Create Paybill"

    assert_text "Paybill was successfully created"
    click_on "Back"
  end

  test "updating a Paybill" do
    visit paybills_url
    click_on "Edit", match: :first

    fill_in "Account number", with: @paybill.account_number
    fill_in "Amount", with: @paybill.amount
    fill_in "First name", with: @paybill.first_name
    fill_in "Invoice number", with: @paybill.invoice_number
    fill_in "Last name", with: @paybill.last_name
    fill_in "Middle name", with: @paybill.middle_name
    fill_in "Paybill balance", with: @paybill.paybill_balance
    fill_in "Phone", with: @paybill.phone
    fill_in "Request", with: @paybill.request
    fill_in "Short code", with: @paybill.short_code
    fill_in "Third party transaction", with: @paybill.third_party_transaction_id
    fill_in "Transaction reference", with: @paybill.transaction_reference
    fill_in "Type", with: @paybill.type
    click_on "Update Paybill"

    assert_text "Paybill was successfully updated"
    click_on "Back"
  end

  test "destroying a Paybill" do
    visit paybills_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Paybill was successfully destroyed"
  end
end
