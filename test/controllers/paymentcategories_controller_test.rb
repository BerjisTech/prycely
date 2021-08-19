# frozen_string_literal: true

require 'test_helper'

class PaymentcategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paymentcategory = paymentcategories(:one)
  end

  test 'should get index' do
    get paymentcategories_url
    assert_response :success
  end

  test 'should get new' do
    get new_paymentcategory_url
    assert_response :success
  end

  test 'should create paymentcategory' do
    assert_difference('Paymentcategory.count') do
      post paymentcategories_url,
           params: { paymentcategory: { created_by: @paymentcategory.created_by, group_id: @paymentcategory.group_id,
                                        name: @paymentcategory.name, type: @paymentcategory.type } }
    end

    assert_redirected_to paymentcategory_url(Paymentcategory.last)
  end

  test 'should show paymentcategory' do
    get paymentcategory_url(@paymentcategory)
    assert_response :success
  end

  test 'should get edit' do
    get edit_paymentcategory_url(@paymentcategory)
    assert_response :success
  end

  test 'should update paymentcategory' do
    patch paymentcategory_url(@paymentcategory),
          params: { paymentcategory: { created_by: @paymentcategory.created_by, group_id: @paymentcategory.group_id,
                                       name: @paymentcategory.name, type: @paymentcategory.type } }
    assert_redirected_to paymentcategory_url(@paymentcategory)
  end

  test 'should destroy paymentcategory' do
    assert_difference('Paymentcategory.count', -1) do
      delete paymentcategory_url(@paymentcategory)
    end

    assert_redirected_to paymentcategories_url
  end
end
