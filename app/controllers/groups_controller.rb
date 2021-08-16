# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[show edit update destroy]

  # GET /groups or /groups.json
  def index
    # @groups = Group.all
    @groups = Member.where.not(status: "0").where(user_id: current_user.id).joins(:group).select(:id, :name,
                                                                                                 :membership, :group_id, :created_by, :currency, :group_type)
  end

  # GET /groups/1 or /groups/1.json
  def show
    @account_check = Member.where(group_id: @group.id)
    if @account_check.count.zero? || @account_check.length.zero? || @account_check.empty? || @account_check.nil?
      if current_user.id == @group.created_by
        @admin_account = Member.new(invited_by: current_user.id, user_id: current_user.id,
                                    group_id: params[:id], designation: "admin", status: "1", invited_on: DateTime.now, accepted_on: DateTime.now, paid_member: "", amount: 0, account_id: @account[0])

        if @admin_account.save
          respond_to do |format|
            format.html { redirect_to group_url(params[:id]), notice: "Your admin account has succsefully been set up" }
            format.json { head :no_content }
          end
        else
          render json: @admin_account.errors
        end
      end
    else
      redirect_to dashboard_path, notice: "You tried accessing a group you're not a member of" if @me.nil?
      if @me.status == "0"
        @inviter = Account.find_by(user_id: @me.invited_by)
        @invite_check = Invite.find_by(invite_email: current_user.email, group_id: @group.id)
        if @invite_check.nil?
          redirect_to dashboard_path, notice: "This invite key is invalid"
        else
          session[:invite_key] = @invite_check.invite_key
        end
      end
    end
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
        format.html { redirect_to @group, notice: "Group was successfully created." }
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
        format.html { redirect_to @group, notice: "Group was successfully updated." }
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
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
    @me = Member.find_by(user_id: current_user.id, group_id: params[:id])
    @account = Account.where(user_id: current_user.id).pluck(:id)
    session[:current_group] = @group.id
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:created_by, :name, :currency, :group_type, :membership, :description)
  end
end
