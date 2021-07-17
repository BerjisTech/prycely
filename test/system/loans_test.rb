require "application_system_test_case"

class LoansTest < ApplicationSystemTestCase
  setup do
    @loan = loans(:one)
  end

  test "visiting the index" do
    visit loans_url
    assert_selector "h1", text: "Loans"
  end

  test "creating a Loan" do
    visit loans_url
    click_on "New Loan"

    fill_in "Amount", with: @loan.amount
    fill_in "Amount due", with: @loan.amount_due
    fill_in "Created by", with: @loan.created_by
    fill_in "Date due", with: @loan.date_due
    fill_in "Date granted", with: @loan.date_granted
    fill_in "Date paid", with: @loan.date_paid
    fill_in "Group", with: @loan.group_id
    fill_in "Guarantors", with: @loan.guarantors
    fill_in "Interest", with: @loan.interest
    fill_in "Requirements", with: @loan.requirements
    fill_in "Status", with: @loan.status
    fill_in "Type", with: @loan.type
    fill_in "User", with: @loan.user_id
    click_on "Create Loan"

    assert_text "Loan was successfully created"
    click_on "Back"
  end

  test "updating a Loan" do
    visit loans_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @loan.amount
    fill_in "Amount due", with: @loan.amount_due
    fill_in "Created by", with: @loan.created_by
    fill_in "Date due", with: @loan.date_due
    fill_in "Date granted", with: @loan.date_granted
    fill_in "Date paid", with: @loan.date_paid
    fill_in "Group", with: @loan.group_id
    fill_in "Guarantors", with: @loan.guarantors
    fill_in "Interest", with: @loan.interest
    fill_in "Requirements", with: @loan.requirements
    fill_in "Status", with: @loan.status
    fill_in "Type", with: @loan.type
    fill_in "User", with: @loan.user_id
    click_on "Update Loan"

    assert_text "Loan was successfully updated"
    click_on "Back"
  end

  test "destroying a Loan" do
    visit loans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Loan was successfully destroyed"
  end
end
