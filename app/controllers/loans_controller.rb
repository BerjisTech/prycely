# frozen_string_literal: true

class LoansController < ApplicationController
  before_action :has_active_group?
  before_action :authenticate_user!
  before_action :set_loan, only: %i[show edit update destroy]
  before_action :has_active_group?, except: :index
  before_action :set_group_by_session

  # GET /loans or /loans.json
  def index
    @loans = Loan.mine(current_user.id)
  end

  def group
    @group = Group.find(params[:group_id])
  end

  # GET /loans/1 or /loans/1.json
  def show
    @loan_payments = Transaction.all
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit
    if !Member.is_manager(current_user.id) || @loan.user_id == current_user.id
      back_url = if request.referer.present?
                   request.referer
                 else
                   loans_path
                 end
      message = if @loan.user_id == current_user.id
                  'You cannot edit your own loan'
                elsif !Member.is_manager(current_user.id)
                  'You are not allowed to perform this action'
                end
      redirect_to back_url, notice: message
    end
  end

  # POST /loans or /loans.json
  def create
    @loan = Loan.new(loan_params)
    @loan.group_id = session[:current_group]
    @loan.status = 0
    @loan.amount_paid = 0
    @loan.interest = Loancategory.calculate_total_with_interest(@loan.amount, @loan.loan_type)
    @loan.amount_due = @loan.amount + @loan.interest
    @loan.date_granted = Time.now if @loan.date_granted.nil?

    @loan.date_due = Loancategory.get_date_due(@loan.date_granted, @loan.loan_type)

    respond_to do |format|
      if Loan.own_guarantor(@loan.guarantors, @loan.user_id) == 1
        @loan.errors.add(:guarantors, 'You cannot guarantor yourself')
        @loan.guarantors = ''
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      elsif @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def own_guarantor
    render json: Loan.own_guarantor(params[:guarantors], params[:user_id])
  end

  def guarantor_limit
    loan_category = Loancategory.find(params[:loan_category])
    guarantors = loan_category.required_guarantos.to_i
    render json: if guarantors > params[:guarantor_count].to_i
                   {
                     status: 'error',
                     message: "You need at least #{guarantors} guarantors to get #{loan_category.name.humanize}"
                   }
                 else
                   {
                     status: 'success',
                     message: "You have reached the minimum required guarantors to get #{loan_category.name.humanize}"
                   }
                 end
  end

  def i_approve
    loan = Loan.find(params[:loan_id])
    response = []

    response << if loan.status == 1
                  {
                    type: 'failed',
                    message: 'This loan has already been approved'
                  }
                elsif LoanApproval.find_by(loan_id: params[:loan_id], user_id: params[:user_id]).present?
                  {
                    type: 'failed',
                    message: 'You already approved this loan'
                  }
                elsif params[:user_id] != current_user.id
                  {
                    type: 'failed',
                    message: 'Bitch ass'
                  }
                elsif Member.is_manager(params[:user_id], session[:current_group])
                  PrycelyMailer.new_approval_email('accounts@prycely.com',
                                                   User.find(loan.user_id).email, "New Approval for your #{Loancategory.find(loan.loan_type).name}", params[:user_id], loan)
                  if (LoanApproval.where(loan_id: params[:loan_id]).count + 1) == Loancategory.find(loan.loan_type).approvals
                    loan.update(status: 1)
                    PrycelyMailer.loan_approved_email('accounts@prycely.com',
                                                      User.find(loan.user_id).email, "Your #{Loancategory.find(loan.loan_type).name} loan has been approved.", params[:user_id], loan)
                  end
                  LoanApproval.find_or_create_by(loan_id: params[:loan_id], user_id: params[:user_id])
                  {
                    type: 'success',
                    message: 'Loan approved',
                    approval_path: i_disapprove_path,
                    icon: 'cancel',
                    remove_color: 'text-primary',
                    add_color: 'text-danger',
                    loan_status: Loan.find(params[:loan_id]).status
                  }
                else
                  {
                    type: 'failed',
                    message: 'Fuck off'
                  }
                end

    render json: response
  end

  def i_disapprove
    loan_approval = LoanApproval.find_by(loan_id: params[:loan_id], user_id: params[:user_id])
    loan = Loan.find(params[:loan_id])

    response = []
    response << if loan_approval.blank?
                  { type: 'failed',
                    message: 'Can\'t do dat',
                    loan_approval: loan_approval }
                elsif params[:user_id] != current_user.id
                  { type: 'failed',
                    message: 'Fuck off' }
                elsif Member.is_admin(params[:user_id], session[:current_group])
                  loan_approval.destroy
                  loan.update(status: 0) if loan.status != 0

                  { type: 'success',
                    message: 'Loan disapproved',
                    approval_path: i_approve_path,
                    icon: 'check',
                    remove_color: 'text-danger',
                    add_color: 'text-primary' }
                else
                  { type: 'failed',
                    message: 'Fuck off' }
                end

    render json: response
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

  def pay
    render json: group_members_path('hex', 'gid')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_loan
    @loan = Loan.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def loan_params
    params.require(:loan).permit(:group_id, :created_by, :user_id, :amount, :amount_paid, :loan_type, :amount_due, :interest,
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
