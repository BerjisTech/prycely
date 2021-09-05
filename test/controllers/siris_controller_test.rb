require "test_helper"

class SirisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @siri = siris(:one)
  end

  test "should get index" do
    get siris_url
    assert_response :success
  end

  test "should get new" do
    get new_siri_url
    assert_response :success
  end

  test "should create siri" do
    assert_difference('Siri.count') do
      post siris_url, params: { siri: { name: @siri.name, value: @siri.value } }
    end

    assert_redirected_to siri_url(Siri.last)
  end

  test "should show siri" do
    get siri_url(@siri)
    assert_response :success
  end

  test "should get edit" do
    get edit_siri_url(@siri)
    assert_response :success
  end

  test "should update siri" do
    patch siri_url(@siri), params: { siri: { name: @siri.name, value: @siri.value } }
    assert_redirected_to siri_url(@siri)
  end

  test "should destroy siri" do
    assert_difference('Siri.count', -1) do
      delete siri_url(@siri)
    end

    assert_redirected_to siris_url
  end
end
