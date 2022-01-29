# frozen_string_literal: true

require 'application_system_test_case'

class DesignationsTest < ApplicationSystemTestCase
  setup do
    @designation = designations(:one)
  end

  test 'visiting the index' do
    visit designations_url
    assert_selector 'h1', text: 'Designations'
  end

  test 'creating a Designation' do
    visit designations_url
    click_on 'New Designation'

    fill_in 'Name', with: @designation.name
    click_on 'Create Designation'

    assert_text 'Designation was successfully created'
    click_on 'Back'
  end

  test 'updating a Designation' do
    visit designations_url
    click_on 'Edit', match: :first

    fill_in 'Name', with: @designation.name
    click_on 'Update Designation'

    assert_text 'Designation was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Designation' do
    visit designations_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Designation was successfully destroyed'
  end
end
