# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]
  before_action :set_account

  # GET /groups or /groups.json
  def index
    # @groups = Group.all
    @groups = Group.mine(current_user.id)
  end

  # GET /groups/1 or /groups/1.json
  def show
    check_account(current_user.id, params[:id], current_user.email, @account, @group)
    # render json: Group.transactions(@group.id, Date.today - 300.days, Date.today)
  end

  # GET /groups/new
  def new
    @group = Group.new
    @currency = Currency.all
  end

  # GET /groups/1/edit
  def edit; end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.created_by.nil? || @group.name.nil? || @group.group_type.nil?
        format.html { redirect_to groups_path, notice: "Some info is missing.#{@group.inspect}" }
      elsif @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def transactions
    if params[:group_id].blank? || params[:from].blank? || params[:to].blank?
      output_file = '<%= render "layouts/common/missing_attribute" %>'
    else
      group_id = params[:group_id]
      from = params[:from]
      to = params[:to]

      @transactions = Group.table_transactions(group_id, from, to)

      if @transactions.count.positive?
      output_file = '<%= render "groups/group/transactions/transactions" %>'
      else
        @start_date = Date.today - from.to_i.days
        @end_date = Date.today - to.to_i.days
        output_file = '<%= render "groups/group/alerts/no_transactions" %>'
      end
    end
    render inline: output_file
  end

  def bar_line_charts
    if params[:group_id].blank? || params[:from].blank? || params[:to].blank?
      output = {
        type: 'error',
        message: 'Some attributes are missing'
      }
    else
      group_id = params[:group_id]
      from = params[:from]
      to = params[:to]

      transactions = Group.graph_transactions(group_id, from, to, Account.find_by(user_id: current_user.id))
      if transactions.count.positive?
        output =  {
          type: 'data',
          data: transactions
        }
      else
        @start_date = Date.today - from.to_i.days
        @end_date = Date.today - to.to_i.days
        output = {
          type: 'info',
          message: "You have no transactions records between 
                    <span class='text-info'>#{@start_date.strftime("%A #{@start_date.day.ordinalize}, %B %Y")}</span> 
                    and 
                    <span class='text-info'>#{@end_date.strftime("%A #{@end_date.day.ordinalize}, %B %Y")}</span>"
        }
      end
    end

    render json: output
  end

  def projects

    if params[:group_id].blank?
      output = '<%= render "layouts/common/missing_attribute" %>'
    else
      @projects = Project.where(group_id: params[:group_id]).order(:created_at)
      @group = Group.find(params[:group_id])
      if @projects.count.positive?
        output = '<%= render "groups/group/projects/projects" %>'
      else
        output = '<%= render "groups/group/alerts/no_projects" %>'
      end
    end

    render inline: output
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
    @my_groups = Group.mine(current_user.id, 5)
    @credit = Transact.amount_from_cents(Group.credit(params[:id]))
    @debit = Transact.amount_from_cents(Group.debit(params[:id]))
    @balance = Group.balance(params[:id])
    @recent_transactions = Transaction.for_group(params[:id], 10)
    @total_transactions = Transaction.total(params[:id])
    @total_members = Member.total_members(params[:id])
    @last_log = Log.last_of_group(params[:id])
    @me = Group.me(current_user.id, params[:id])
    session[:current_group] = @group.id
  end

  def set_account
    @account = Account.find_by(user_id: current_user.id)
  end

  def check_account(user_id, group_id, user_email, account, group)
    account_check = Member.where(group_id: group_id)

    if account_check.count.zero? || account_check.length.zero? || account_check.empty? || account_check.nil?
      create_group_admin(user_id, group_id, account, group)
    else
      me = Group.me(user_id, group_id)
      stop_unwanted_user(me, group_id, user_email)
    end
  end

  def create_group_admin(user_id, group_id, account, group)
    if user_id == group.created_by
      admin_account = Member.new(invited_by: user_id, user_id: user_id,
                                 group_id: group_id, designation: 'admin', status: '1', invited_on: DateTime.now, accepted_on: DateTime.now, paid_member: '', amount: 0, account_id: account.id)

      if admin_account.save
        redirect_to group_url(group_id), notice: 'Your admin account has succsefully been set up'
      else
        render json: admin_account.errors
      end
    end
  end

  def stop_unwanted_user(me, group_id, user_email)
    redirect_to dashboard_path, notice: "You tried accessing a group you're not a member of" if me.nil?
    if me.status == '0'
      invite_check = Invite.find_by(invite_email: user_email, group_id: group_id)

      if invite_check.nil?
        redirect_to dashboard_path, notice: 'This invite key is invalid'
      else
        session[:invite_key] = invite_check.invite_key
      end
    end
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:created_by, :name, :currency, :group_type, :membership, :description)
  end
end
