# frozen_string_literal: true

require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:one)
  end

  test "should get index" do
    get accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_account_url
    assert_response :success
  end

  test "should create account" do
    assert_difference("Account.count") do
      post accounts_url,
           params: { account: { address: @account.address, city: @account.city, country: @account.country,
                               county: @account.county, deactivated: @account.deactivated, first_name: @account.first_name, last_name: @account.last_name, phone: @account.phone, photo: @account.photo, postal: @account.postal, street: @account.street, tour: @account.tour, type: @account.type, user_id: @account.user_id, verified: @account.verified } }
    end

    assert_redirected_to account_url(Account.last)
  end

  test "should show account" do
    get account_url(@account)
    assert_response :success
  end

  test "should get edit" do
    get edit_account_url(@account)
    assert_response :success
  end

  test "should update account" do
    patch account_url(@account),
          params: { account: { address: @account.address, city: @account.city, country: @account.country,
                              county: @account.county, deactivated: @account.deactivated, first_name: @account.first_name, last_name: @account.last_name, phone: @account.phone, photo: @account.photo, postal: @account.postal, street: @account.street, tour: @account.tour, type: @account.type, user_id: @account.user_id, verified: @account.verified } }
    assert_redirected_to account_url(@account)
  end

  test "should destroy account" do
    assert_difference("Account.count", -1) do
      delete account_url(@account)
    end

    assert_redirected_to accounts_url
  end
end
