# frozen_string_literal: true

require "test_helper"

class GrouptypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grouptype = grouptypes(:one)
  end

  test "should get index" do
    get grouptypes_url
    assert_response :success
  end

  test "should get new" do
    get new_grouptype_url
    assert_response :success
  end

  test "should create grouptype" do
    assert_difference("Grouptype.count") do
      post grouptypes_url, params: { grouptype: { name: @grouptype.name } }
    end

    assert_redirected_to grouptype_url(Grouptype.last)
  end

  test "should show grouptype" do
    get grouptype_url(@grouptype)
    assert_response :success
  end

  test "should get edit" do
    get edit_grouptype_url(@grouptype)
    assert_response :success
  end

  test "should update grouptype" do
    patch grouptype_url(@grouptype), params: { grouptype: { name: @grouptype.name } }
    assert_redirected_to grouptype_url(@grouptype)
  end

  test "should destroy grouptype" do
    assert_difference("Grouptype.count", -1) do
      delete grouptype_url(@grouptype)
    end

    assert_redirected_to grouptypes_url
  end
end
