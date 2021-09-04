# frozen_string_literal: true

require "application_system_test_case"

class GrouptypesTest < ApplicationSystemTestCase
  setup do
    @grouptype = grouptypes(:one)
  end

  test "visiting the index" do
    visit grouptypes_url
    assert_selector "h1", text: "Grouptypes"
  end

  test "creating a Grouptype" do
    visit grouptypes_url
    click_on "New Grouptype"

    fill_in "Name", with: @grouptype.name
    click_on "Create Grouptype"

    assert_text "Grouptype was successfully created"
    click_on "Back"
  end

  test "updating a Grouptype" do
    visit grouptypes_url
    click_on "Edit", match: :first

    fill_in "Name", with: @grouptype.name
    click_on "Update Grouptype"

    assert_text "Grouptype was successfully updated"
    click_on "Back"
  end

  test "destroying a Grouptype" do
    visit grouptypes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Grouptype was successfully destroyed"
  end
end
