# frozen_string_literal: true

require 'application_system_test_case'

class LiabilitiesTest < ApplicationSystemTestCase
  setup do
    @liability = liabilities(:one)
  end

  test 'visiting the index' do
    visit liabilities_url
    assert_selector 'h1', text: 'Liabilities'
  end

  test 'creating a Liability' do
    visit liabilities_url
    click_on 'New Liability'

    fill_in 'Added by', with: @liability.added_by
    fill_in 'Date bought', with: @liability.date_bought
    fill_in 'Date sold', with: @liability.date_sold
    fill_in 'Description', with: @liability.description
    fill_in 'Group', with: @liability.group_id
    fill_in 'Name', with: @liability.name
    fill_in 'Price', with: @liability.price
    click_on 'Create Liability'

    assert_text 'Liability was successfully created'
    click_on 'Back'
  end

  test 'updating a Liability' do
    visit liabilities_url
    click_on 'Edit', match: :first

    fill_in 'Added by', with: @liability.added_by
    fill_in 'Date bought', with: @liability.date_bought
    fill_in 'Date sold', with: @liability.date_sold
    fill_in 'Description', with: @liability.description
    fill_in 'Group', with: @liability.group_id
    fill_in 'Name', with: @liability.name
    fill_in 'Price', with: @liability.price
    click_on 'Update Liability'

    assert_text 'Liability was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Liability' do
    visit liabilities_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Liability was successfully destroyed'
  end
end
