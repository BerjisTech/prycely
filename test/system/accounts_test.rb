# frozen_string_literal: true

require 'application_system_test_case'

class AccountsTest < ApplicationSystemTestCase
  setup do
    @account = accounts(:one)
  end

  test 'visiting the index' do
    visit accounts_url
    assert_selector 'h1', text: 'Accounts'
  end

  test 'creating a Account' do
    visit accounts_url
    click_on 'New Account'

    fill_in 'Address', with: @account.address
    fill_in 'City', with: @account.city
    fill_in 'Country', with: @account.country
    fill_in 'County', with: @account.county
    fill_in 'Deactivated', with: @account.deactivated
    fill_in 'First name', with: @account.first_name
    fill_in 'Last name', with: @account.last_name
    fill_in 'Phone', with: @account.phone
    fill_in 'Photo', with: @account.photo
    fill_in 'Postal', with: @account.postal
    fill_in 'Street', with: @account.street
    fill_in 'Tour', with: @account.tour
    fill_in 'Type', with: @account.type
    fill_in 'User', with: @account.user_id
    fill_in 'Verified', with: @account.verified
    click_on 'Create Account'

    assert_text 'Account was successfully created'
    click_on 'Back'
  end

  test 'updating a Account' do
    visit accounts_url
    click_on 'Edit', match: :first

    fill_in 'Address', with: @account.address
    fill_in 'City', with: @account.city
    fill_in 'Country', with: @account.country
    fill_in 'County', with: @account.county
    fill_in 'Deactivated', with: @account.deactivated
    fill_in 'First name', with: @account.first_name
    fill_in 'Last name', with: @account.last_name
    fill_in 'Phone', with: @account.phone
    fill_in 'Photo', with: @account.photo
    fill_in 'Postal', with: @account.postal
    fill_in 'Street', with: @account.street
    fill_in 'Tour', with: @account.tour
    fill_in 'Type', with: @account.type
    fill_in 'User', with: @account.user_id
    fill_in 'Verified', with: @account.verified
    click_on 'Update Account'

    assert_text 'Account was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Account' do
    visit accounts_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Account was successfully destroyed'
  end
end
