# frozen_string_literal: true

class RedeemsController < ApplicationController
  before_action :set_redeem, only: %i[show edit update destroy]

  # GET /redeems or /redeems.json
  def index
    @redeems = Redeem.where(user_id: current_user.id).joins(:group).joins(user: :accounts).select(:first_name,
                                                                                                  :name, :email, :group_id, :group_type, :description)
  end

  def redeem
    @invite_key = params[:id]
    @invite = Invite.where(invite_key: @invite_key).joins(:group).joins(user: :accounts).select(:id, :first_name,
                                                                                                :name, :email, :group_id, :group_type, :description, :user_id, :total_redeemed)
    # render json: @invite

    if @invite.length.zero? || @invite == 'null' || @invite.empty?
      respond_to do |format|
        format.html { redirect_to root_path, notice: "This invite link is either expired or doesn't exist." }
        format.json { render :show, status: :created, location: @invite }
      end
    else
      @invite = @invite[0]

      @new_redeem_count = @invite.total_redeemed.to_i + 1
      if user_signed_in?
        @already_invited = Member.find_by(group_id: @invite.group_id, user_id: current_user.id)
        @group = Group.find(@invite.group_id)

        if @already_invited.nil?
          @account = Account.where(user_id: current_user.id).pluck(:id)
          Member.new(invited_by: @invite.user_id, user_id: current_user.id, group_id: @invite.group_id,
                     designation: 'member', status: '1', invited_on: DateTime.now, accepted_on: DateTime.now, paid_member: '', amount: 0, account_id: @account[0]).save
          Redeem.new(invite_id: @invite.id, user_id: current_user.id, group_id: @invite.group_id,
                     complete: 1).save
          Invite.where(invite_key: @invite_key).update_all(total_redeemed: @new_redeem_count)

          redirect_to @group, notice: "You have succesfully joined #{@group.name}"
        else
          redirect_to @group, notice: "You're already a member of this group"
        end
      else
        session[:current_group] = @invite.group_id
        session[:invite_key] = @invite_key

        @grouptype = case @invite.group_type
                     when '1'
                       'Friends and Family'
                     when '2'
                       'Temporary or Mid-sized (Church, Fundraiser etc)'
                     when '3'
                       'Cooperative & Saccos'
                     else
                       'Wash Wash'
                     end
      end
    end
  end

  def accept_invite
    @invite_key = session[:invite_key]
    @invite = Invite.find_by(invite_key: @invite_key)
    Invite.where(invite_key: @invite_key).update_all(total_redeemed: 1)
    Member.where(group_id: session[:current_group]).where(user_id: current_user.id).update_all(status: '1')
    Redeem.where(invite_id: @invite_key).update_all(complete: 1)
    @group = Group.find(session[:current_group])
    redirect_to @group, notice: "You have succesfully joined #{@group.name}"
  end

  # GET /redeems/1 or /redeems/1.json
  def show; end

  # GET /redeems/new
  def new
    @redeem = Redeem.new
  end

  # GET /redeems/1/edit
  def edit; end

  # POST /redeems or /redeems.json
  def create
    @redeem = Redeem.new(redeem_params)

    respond_to do |format|
      if @redeem.save
        format.html { redirect_to @redeem, notice: 'Redeem was successfully created.' }
        format.json { render :show, status: :created, location: @redeem }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @redeem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /redeems/1 or /redeems/1.json
  def update
    respond_to do |format|
      if @redeem.update(redeem_params)
        format.html { redirect_to @redeem, notice: 'Redeem was successfully updated.' }
        format.json { render :show, status: :ok, location: @redeem }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @redeem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /redeems/1 or /redeems/1.json
  def destroy
    @redeem.destroy
    respond_to do |format|
      format.html { redirect_to redeems_url, notice: 'Redeem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_redeem
    @redeem = Redeem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def redeem_params
    params.require(:redeem).permit(:invite_id, :user_id, :group_id, :complete)
  end
end
