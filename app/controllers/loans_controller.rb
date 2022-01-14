# frozen_string_literal: true

class LoansController < ApplicationController
  before_action :has_active_group?
  before_action :authenticate_user!
  before_action :set_loan, only: %i[show edit update destroy]
  before_action :set_group

  # GET /loans or /loans.json
  def index
    @loans = Loan.all
  end

  def group
    @group = Group.find(params[:group_id])
  end

  # GET /loans/1 or /loans/1.json
  def show; end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit; end

  # POST /loans or /loans.json
  def create
    @loan = Loan.new(loan_params)
    @loan.group_id = session[:current_group]
    @loan.user_id = current_user.id
    @loan.status = 0
    @loan.interest = Loancategory.calculate_total_with_interest(@loan.amount, @loan.loan_type)
    @loan.amount_due = @loan.amount + @loan.interest

    @loan.date_due = Loancategory.get_date_due(@loan.date_granted, @loan.loan_type)

    respond_to do |format|
      if Loan.own_guarantor(@loan.guarantors,  @loan.user_id).positive?
        @loan.guarantors = ''
        format.html { redirect_to new_loan_path, notice: 'You cannot be your own guarantor' }
      elsif @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1 or /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1 or /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_loan
    @loan = Loan.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def loan_params
    params.require(:loan).permit(:group_id, :created_by, :user_id, :amount, :loan_type, :amount_due, :interest,
                                 :status, :guarantors, :date_granted, :date_due, :date_paid, :requirements)
  end

  def set_group
    if session[:current_group].present?
      @group = Group.find(session[:current_group])
    else
      redirect_to groups_path, notice: 'Select a group to see the transactions'
    end
  end
end
