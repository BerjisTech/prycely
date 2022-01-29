# frozen_string_literal: true

require 'test_helper'

class DesignationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @designation = designations(:one)
  end

  test 'should get index' do
    get designations_url
    assert_response :success
  end

  test 'should get new' do
    get new_designation_url
    assert_response :success
  end

  test 'should create designation' do
    assert_difference('Designation.count') do
      post designations_url, params: { designation: { name: @designation.name } }
    end

    assert_redirected_to designation_url(Designation.last)
  end

  test 'should show designation' do
    get designation_url(@designation)
    assert_response :success
  end

  test 'should get edit' do
    get edit_designation_url(@designation)
    assert_response :success
  end

  test 'should update designation' do
    patch designation_url(@designation), params: { designation: { name: @designation.name } }
    assert_redirected_to designation_url(@designation)
  end

  test 'should destroy designation' do
    assert_difference('Designation.count', -1) do
      delete designation_url(@designation)
    end

    assert_redirected_to designations_url
  end
end
