# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]
  before_action :set_account

  # GET /groups or /groups.json
  def index
    # @groups = Group.all
    @my_group_transactions = Transaction.my_group_transactions(current_user.id)
    @my_groups_numbers = OpenStruct.new Dashboard.group_numbers(current_user.id)
    @groups = Member.where.not(status: '0').where(user_id: current_user.id).joins(:group).select(:id, :name, :accepted_on,
                                                                                                 :membership, :group_id, :created_by, :currency, :group_type)
    # render json: @my_group_transactions
  end

  # GET /groups/1 or /groups/1.json
  def show
    check_account(current_user.id, params[:id], current_user.email, @account, @group)
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
      if @group.save
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
    @my_groups = Group.mine(current_user.id, 5)
    @credit = Transact.amount_from_cents(Group.credit(params[:id]))
    @debit = Transact.amount_from_cents(Group.debit(params[:id]))
    @balance = Transact.amount_from_cents(Group.balance(params[:id]))
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
                                 group_id: group_id, designation: 'admin', status: '1', invited_on: DateTime.now, accepted_on: DateTime.now, paid_member: '', amount: 0, account_id: account.first)

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
