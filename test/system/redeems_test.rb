# frozen_string_literal: true

require 'application_system_test_case'

class RedeemsTest < ApplicationSystemTestCase
  setup do
    @redeem = redeems(:one)
  end

  test 'visiting the index' do
    visit redeems_url
    assert_selector 'h1', text: 'Redeems'
  end

  test 'creating a Redeem' do
    visit redeems_url
    click_on 'New Redeem'

    fill_in 'Invite', with: @redeem.invite_id
    click_on 'Create Redeem'

    assert_text 'Redeem was successfully created'
    click_on 'Back'
  end

  test 'updating a Redeem' do
    visit redeems_url
    click_on 'Edit', match: :first

    fill_in 'Invite', with: @redeem.invite_id
    click_on 'Update Redeem'

    assert_text 'Redeem was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Redeem' do
    visit redeems_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Redeem was successfully destroyed'
  end
end
