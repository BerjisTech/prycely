require "application_system_test_case"

class MembersTest < ApplicationSystemTestCase
  setup do
    @member = members(:one)
  end

  test "visiting the index" do
    visit members_url
    assert_selector "h1", text: "Members"
  end

  test "creating a Member" do
    visit members_url
    click_on "New Member"

    fill_in "Accepted on", with: @member.accepted_on
    fill_in "Amount", with: @member.amount
    fill_in "Designation", with: @member.designation
    fill_in "Group", with: @member.group_id
    fill_in "Invited by", with: @member.invited_by
    fill_in "Invited on", with: @member.invited_on
    fill_in "Paid member", with: @member.paid_member
    fill_in "Status", with: @member.status
    fill_in "User", with: @member.user_id
    click_on "Create Member"

    assert_text "Member was successfully created"
    click_on "Back"
  end

  test "updating a Member" do
    visit members_url
    click_on "Edit", match: :first

    fill_in "Accepted on", with: @member.accepted_on
    fill_in "Amount", with: @member.amount
    fill_in "Designation", with: @member.designation
    fill_in "Group", with: @member.group_id
    fill_in "Invited by", with: @member.invited_by
    fill_in "Invited on", with: @member.invited_on
    fill_in "Paid member", with: @member.paid_member
    fill_in "Status", with: @member.status
    fill_in "User", with: @member.user_id
    click_on "Update Member"

    assert_text "Member was successfully updated"
    click_on "Back"
  end

  test "destroying a Member" do
    visit members_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Member was successfully destroyed"
  end
end
