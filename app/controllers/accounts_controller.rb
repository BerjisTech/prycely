# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[show edit update destroy]

  # GET /accounts or /accounts.json
  def index
    # @accounts = Account.all.with_attached_image
    @accounts = current_user.accounts
  end

  # GET /accounts/1 or /accounts/1.json
  def show; end

  # GET /accounts/new
  def new
    # @account = Account.new
    @my_account = Account.where(user_id: current_user.id)
    if @my_account.count.zero? || @my_account.length.zero? || @my_account.empty?
      @account = current_user.accounts.build
    else
      respond_to do |format|
        format.html { redirect_to dashboard_url, notice: "Your account has already been set up" }
        format.json { head :no_content }
      end
    end
  end

  # GET /accounts/1/edit
  def edit; end

  # POST /accounts or /accounts.json
  def create
    # @account = Account.new(account_params)
    @account = current_user.accounts.build(account_params)

    @account.image.attach(params[:account][:image])

    if @account.save
      if session[:invite_key]
        accept_current_invite(@account)
      else
        redirect_to @account, notice: "Account was successfully created."
      end
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: "Account was successfully updated." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @user = current_user.accounts.find_by(user_id: current_user.id)
    redirect_to accounts_path, notice: "You're not authorized to perform this action" if @user.nil?
  end

  def accept_current_invite(_account)
    @invite_key = session[:invite_key]
    @invite = Invite.where(invite_key: @invite_key).joins(:group).joins(user: :accounts).select(
      :id,
      :first_name,
      :name,
      :email,
      :group_id,
      :group_type,
      :description,
      :user_id,
      :total_redeemed
    ).first

    @new_redeem_count = @invite.total_redeemed.to_i + 1
    @check_account = Account.where(user_id: current_user.id).pluck(:id)
    @already_invited = Member.find_by(group_id: @invite.group_id, user_id: current_user.id)
    @group = Group.find(@invite.group_id)

    if @already_invited.nil?
      @join_member = Member.new(
        invited_by: @invite.user_id,
        user_id: current_user.id,
        group_id: @invite.group_id,
        designation: "member",
        status: "1",
        invited_on: DateTime.now,
        accepted_on: DateTime.now,
        paid_member: "",
        amount: 0,
        account_id: @account.id,
      )

      @join_redeem = Redeem.new(
        invite_id: @invite.id,
        user_id: current_user.id,
        group_id: @invite.group_id,
        complete: 1,
      )

      if @join_member.save
        if @join_redeem.save
          @invite_update = Invite.where(invite_key: @invite_key)
          if @invite_update.update_all(total_redeemed: @new_redeem_count)
            session.delete(:invite_key)
            redirect_to @group, notice: "You have succesfully joined #{@group.name}"
          else
            render json: @invite_update.errors
          end
        else
          render json: @join_redeem.errors
        end
      else
        render json: @join_member.errors
      end
    else
      redirect_to @group, notice: "You're already a member of this group"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(current_user.id)
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:user_id, :phone, :first_name, :last_name, :photo, :deactivated, :verified,
                                    :country, :county, :city, :street, :address, :postal, :account_type, :tour, :image)
  end
end
