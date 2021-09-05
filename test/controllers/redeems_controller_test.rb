# frozen_string_literal: true

require 'test_helper'

class RedeemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @redeem = redeems(:one)
  end

  test 'should get index' do
    get redeems_url
    assert_response :success
  end

  test 'should get new' do
    get new_redeem_url
    assert_response :success
  end

  test 'should create redeem' do
    assert_difference('Redeem.count') do
      post redeems_url, params: { redeem: { invite_id: @redeem.invite_id } }
    end

    assert_redirected_to redeem_url(Redeem.last)
  end

  test 'should show redeem' do
    get redeem_url(@redeem)
    assert_response :success
  end

  test 'should get edit' do
    get edit_redeem_url(@redeem)
    assert_response :success
  end

  test 'should update redeem' do
    patch redeem_url(@redeem), params: { redeem: { invite_id: @redeem.invite_id } }
    assert_redirected_to redeem_url(@redeem)
  end

  test 'should destroy redeem' do
    assert_difference('Redeem.count', -1) do
      delete redeem_url(@redeem)
    end

    assert_redirected_to redeems_url
  end
end
