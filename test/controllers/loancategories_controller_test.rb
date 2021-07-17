require "test_helper"

class LoancategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loancategory = loancategories(:one)
  end

  test "should get index" do
    get loancategories_url
    assert_response :success
  end

  test "should get new" do
    get new_loancategory_url
    assert_response :success
  end

  test "should create loancategory" do
    assert_difference("Loancategory.count") do
      post loancategories_url, params: { loancategory: { amount: @loancategory.amount, created_by: @loancategory.created_by, decsription: @loancategory.decsription, group_id: @loancategory.group_id, interest: @loancategory.interest, interest_rule: @loancategory.interest_rule, name: @loancategory.name, period: @loancategory.period, required_guarantos: @loancategory.required_guarantos, requirements: @loancategory.requirements } }
    end

    assert_redirected_to loancategory_url(Loancategory.last)
  end

  test "should show loancategory" do
    get loancategory_url(@loancategory)
    assert_response :success
  end

  test "should get edit" do
    get edit_loancategory_url(@loancategory)
    assert_response :success
  end

  test "should update loancategory" do
    patch loancategory_url(@loancategory), params: { loancategory: { amount: @loancategory.amount, created_by: @loancategory.created_by, decsription: @loancategory.decsription, group_id: @loancategory.group_id, interest: @loancategory.interest, interest_rule: @loancategory.interest_rule, name: @loancategory.name, period: @loancategory.period, required_guarantos: @loancategory.required_guarantos, requirements: @loancategory.requirements } }
    assert_redirected_to loancategory_url(@loancategory)
  end

  test "should destroy loancategory" do
    assert_difference("Loancategory.count", -1) do
      delete loancategory_url(@loancategory)
    end

    assert_redirected_to loancategories_url
  end
end
