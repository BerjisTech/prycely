# frozen_string_literal: true

require "application_system_test_case"

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @project = projects(:one)
  end

  test "visiting the index" do
    visit projects_url
    assert_selector "h1", text: "Projects"
  end

  test "creating a Project" do
    visit projects_url
    click_on "New Project"

    fill_in "Amount", with: @project.amount
    fill_in "Created by", with: @project.created_by
    fill_in "Currency", with: @project.currency
    fill_in "Description", with: @project.description
    fill_in "Group", with: @project.group_id
    fill_in "Project end", with: @project.project_end
    fill_in "Project start", with: @project.project_start
    fill_in "Status", with: @project.status
    fill_in "Title", with: @project.title
    click_on "Create Project"

    assert_text "Project was successfully created"
    click_on "Back"
  end

  test "updating a Project" do
    visit projects_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @project.amount
    fill_in "Created by", with: @project.created_by
    fill_in "Currency", with: @project.currency
    fill_in "Description", with: @project.description
    fill_in "Group", with: @project.group_id
    fill_in "Project end", with: @project.project_end
    fill_in "Project start", with: @project.project_start
    fill_in "Status", with: @project.status
    fill_in "Title", with: @project.title
    click_on "Update Project"

    assert_text "Project was successfully updated"
    click_on "Back"
  end

  test "destroying a Project" do
    visit projects_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Project was successfully destroyed"
  end
end
