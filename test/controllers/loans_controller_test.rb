# frozen_string_literal: true

require 'test_helper'

class LoansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loan = loans(:one)
  end

  test 'should get index' do
    get loans_url
    assert_response :success
  end

  test 'should get new' do
    get new_loan_url
    assert_response :success
  end

  test 'should create loan' do
    assert_difference('Loan.count') do
      post loans_url,
           params: { loan: { amount: @loan.amount, amount_due: @loan.amount_due, created_by: @loan.created_by,
                             date_due: @loan.date_due, date_granted: @loan.date_granted, date_paid: @loan.date_paid, group_id: @loan.group_id, guarantors: @loan.guarantors, interest: @loan.interest, requirements: @loan.requirements, status: @loan.status, type: @loan.type, user_id: @loan.user_id } }
    end

    assert_redirected_to loan_url(Loan.last)
  end

  test 'should show loan' do
    get loan_url(@loan)
    assert_response :success
  end

  test 'should get edit' do
    get edit_loan_url(@loan)
    assert_response :success
  end

  test 'should update loan' do
    patch loan_url(@loan),
          params: { loan: { amount: @loan.amount, amount_due: @loan.amount_due, created_by: @loan.created_by,
                            date_due: @loan.date_due, date_granted: @loan.date_granted, date_paid: @loan.date_paid, group_id: @loan.group_id, guarantors: @loan.guarantors, interest: @loan.interest, requirements: @loan.requirements, status: @loan.status, type: @loan.type, user_id: @loan.user_id } }
    assert_redirected_to loan_url(@loan)
  end

  test 'should destroy loan' do
    assert_difference('Loan.count', -1) do
      delete loan_url(@loan)
    end

    assert_redirected_to loans_url
  end
end
