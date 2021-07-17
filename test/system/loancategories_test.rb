require "application_system_test_case"

class LoancategoriesTest < ApplicationSystemTestCase
  setup do
    @loancategory = loancategories(:one)
  end

  test "visiting the index" do
    visit loancategories_url
    assert_selector "h1", text: "Loancategories"
  end

  test "creating a Loancategory" do
    visit loancategories_url
    click_on "New Loancategory"

    fill_in "Amount", with: @loancategory.amount
    fill_in "Created by", with: @loancategory.created_by
    fill_in "Decsription", with: @loancategory.decsription
    fill_in "Group", with: @loancategory.group_id
    fill_in "Interest", with: @loancategory.interest
    fill_in "Interest rule", with: @loancategory.interest_rule
    fill_in "Name", with: @loancategory.name
    fill_in "Period", with: @loancategory.period
    fill_in "Required guarantos", with: @loancategory.required_guarantos
    fill_in "Requirements", with: @loancategory.requirements
    click_on "Create Loancategory"

    assert_text "Loancategory was successfully created"
    click_on "Back"
  end

  test "updating a Loancategory" do
    visit loancategories_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @loancategory.amount
    fill_in "Created by", with: @loancategory.created_by
    fill_in "Decsription", with: @loancategory.decsription
    fill_in "Group", with: @loancategory.group_id
    fill_in "Interest", with: @loancategory.interest
    fill_in "Interest rule", with: @loancategory.interest_rule
    fill_in "Name", with: @loancategory.name
    fill_in "Period", with: @loancategory.period
    fill_in "Required guarantos", with: @loancategory.required_guarantos
    fill_in "Requirements", with: @loancategory.requirements
    click_on "Update Loancategory"

    assert_text "Loancategory was successfully updated"
    click_on "Back"
  end

  test "destroying a Loancategory" do
    visit loancategories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Loancategory was successfully destroyed"
  end
end
