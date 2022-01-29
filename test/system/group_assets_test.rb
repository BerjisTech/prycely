# frozen_string_literal: true

require 'application_system_test_case'

class GroupAssetsTest < ApplicationSystemTestCase
  setup do
    @group_asset = group_assets(:one)
  end

  test 'visiting the index' do
    visit group_assets_url
    assert_selector 'h1', text: 'Group Assets'
  end

  test 'creating a Group asset' do
    visit group_assets_url
    click_on 'New Group Asset'

    fill_in 'Date bought', with: @group_asset.date_bought
    fill_in 'Date sold', with: @group_asset.date_sold
    fill_in 'Description', with: @group_asset.description
    fill_in 'Group', with: @group_asset.group_id
    fill_in 'Name', with: @group_asset.name
    fill_in 'Price', with: @group_asset.price
    fill_in 'User', with: @group_asset.user_id
    click_on 'Create Group asset'

    assert_text 'Group asset was successfully created'
    click_on 'Back'
  end

  test 'updating a Group asset' do
    visit group_assets_url
    click_on 'Edit', match: :first

    fill_in 'Date bought', with: @group_asset.date_bought
    fill_in 'Date sold', with: @group_asset.date_sold
    fill_in 'Description', with: @group_asset.description
    fill_in 'Group', with: @group_asset.group_id
    fill_in 'Name', with: @group_asset.name
    fill_in 'Price', with: @group_asset.price
    fill_in 'User', with: @group_asset.user_id
    click_on 'Update Group asset'

    assert_text 'Group asset was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Group asset' do
    visit group_assets_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Group asset was successfully destroyed'
  end
end
