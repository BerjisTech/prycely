require "application_system_test_case"

class SirisTest < ApplicationSystemTestCase
  setup do
    @siri = siris(:one)
  end

  test "visiting the index" do
    visit siris_url
    assert_selector "h1", text: "Siris"
  end

  test "creating a Siri" do
    visit siris_url
    click_on "New Siri"

    fill_in "Name", with: @siri.name
    fill_in "Value", with: @siri.value
    click_on "Create Siri"

    assert_text "Siri was successfully created"
    click_on "Back"
  end

  test "updating a Siri" do
    visit siris_url
    click_on "Edit", match: :first

    fill_in "Name", with: @siri.name
    fill_in "Value", with: @siri.value
    click_on "Update Siri"

    assert_text "Siri was successfully updated"
    click_on "Back"
  end

  test "destroying a Siri" do
    visit siris_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Siri was successfully destroyed"
  end
end
