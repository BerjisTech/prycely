require "application_system_test_case"

class PaymentcategoriesTest < ApplicationSystemTestCase
  setup do
    @paymentcategory = paymentcategories(:one)
  end

  test "visiting the index" do
    visit paymentcategories_url
    assert_selector "h1", text: "Paymentcategories"
  end

  test "creating a Paymentcategory" do
    visit paymentcategories_url
    click_on "New Paymentcategory"

    fill_in "Created by", with: @paymentcategory.created_by
    fill_in "Group", with: @paymentcategory.group_id
    fill_in "Name", with: @paymentcategory.name
    fill_in "Type", with: @paymentcategory.type
    click_on "Create Paymentcategory"

    assert_text "Paymentcategory was successfully created"
    click_on "Back"
  end

  test "updating a Paymentcategory" do
    visit paymentcategories_url
    click_on "Edit", match: :first

    fill_in "Created by", with: @paymentcategory.created_by
    fill_in "Group", with: @paymentcategory.group_id
    fill_in "Name", with: @paymentcategory.name
    fill_in "Type", with: @paymentcategory.type
    click_on "Update Paymentcategory"

    assert_text "Paymentcategory was successfully updated"
    click_on "Back"
  end

  test "destroying a Paymentcategory" do
    visit paymentcategories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Paymentcategory was successfully destroyed"
  end
end
