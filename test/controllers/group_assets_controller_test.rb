# frozen_string_literal: true

require 'test_helper'

class GroupAssetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_asset = group_assets(:one)
  end

  test 'should get index' do
    get group_assets_url
    assert_response :success
  end

  test 'should get new' do
    get new_group_asset_url
    assert_response :success
  end

  test 'should create group_asset' do
    assert_difference('GroupAsset.count') do
      post group_assets_url,
           params: { group_asset: { date_bought: @group_asset.date_bought, date_sold: @group_asset.date_sold,
                                    description: @group_asset.description, group_id: @group_asset.group_id, name: @group_asset.name, price: @group_asset.price, user_id: @group_asset.user_id } }
    end

    assert_redirected_to group_asset_url(GroupAsset.last)
  end

  test 'should show group_asset' do
    get group_asset_url(@group_asset)
    assert_response :success
  end

  test 'should get edit' do
    get edit_group_asset_url(@group_asset)
    assert_response :success
  end

  test 'should update group_asset' do
    patch group_asset_url(@group_asset),
          params: { group_asset: { date_bought: @group_asset.date_bought, date_sold: @group_asset.date_sold,
                                   description: @group_asset.description, group_id: @group_asset.group_id, name: @group_asset.name, price: @group_asset.price, user_id: @group_asset.user_id } }
    assert_redirected_to group_asset_url(@group_asset)
  end

  test 'should destroy group_asset' do
    assert_difference('GroupAsset.count', -1) do
      delete group_asset_url(@group_asset)
    end

    assert_redirected_to group_assets_url
  end
end
