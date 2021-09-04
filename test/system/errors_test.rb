# frozen_string_literal: true

require "application_system_test_case"

class ErrorsTest < ApplicationSystemTestCase
  setup do
    @error = errors(:one)
  end

  test "visiting the index" do
    visit errors_url
    assert_selector "h1", text: "Errors"
  end

  test "creating a Error" do
    visit errors_url
    click_on "New Error"

    fill_in "Error", with: @error.error
    fill_in "Time", with: @error.time
    click_on "Create Error"

    assert_text "Error was successfully created"
    click_on "Back"
  end

  test "updating a Error" do
    visit errors_url
    click_on "Edit", match: :first

    fill_in "Error", with: @error.error
    fill_in "Time", with: @error.time
    click_on "Update Error"

    assert_text "Error was successfully updated"
    click_on "Back"
  end

  test "destroying a Error" do
    visit errors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Error was successfully destroyed"
  end
end
