# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_member, only: %i[show edit update destroy]
  before_action :has_active_group?, except: :index
  before_action :set_group_by_session
  before_action :set_global_for_index, only: %i[index]

  # GET /members or /members.json
  def index
    @members = Member.where(group_id: session[:current_group]).joins(user: :accounts).limit(10).select(
      :first_name, :last_name, :email, :group_id, :user_id, :id, :invited_on, :accepted_on, :invited_by, :designation, :status
    )
    # render json: @members
  end

  def group
    @members = Member.where(group_id: session[:current_group], designation: Designation.find_or_create_by(name: 'Member').id).where("status = '1' or status = '0'").joins(user: :accounts).select(
      :first_name, :last_name, :email, :group_id, :user_id, :id, :invited_on, :accepted_on, :invited_by, :designation, :status
    )
    @managers = Member.where.not(designation: Designation.find_or_create_by(name: 'Member').id).where(group_id: session[:current_group]).where("status = '1' or status = '0'").joins(user: :accounts).select(
      :first_name, :last_name, :email, :group_id, :user_id, :id, :invited_on, :accepted_on, :invited_by, :designation, :status
    )
  end

  # GET /members/1 or /members/1.json
  def show
    @account = Account.find_by(user_id: @member.user_id)
    @my_group_numbers = Transaction.my_group_numbers(@member.user_id, @member.group_id)
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit; end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)

    invite_email = @member.status.gsub(/\s+/, '')

    if !User.is_in_system(invite_email)
      redirect_to new_invite_path,
                  alert: "This member does not exist in our records. Would you like to send them an invite link to join #{@group.name}"
    else

      @member.user_id = User.find_by(email: invite_email).id
      @check_account = Account.find_by(user_id: @member.user_id)
      @member.account_id = @check_account.id

      if Invite.already_sent(invite_email, @group.id)
        redirect_to group_members_path(@group.name, Digest::SHA1.hexdigest(@group.id.to_s), @group.id),
                    notice: "#{Member.full_names(@member.user_id)} is already a member of #{@group.name}"
      elsif Member.is_in_group(@member.user_id, @group.id)

        redirect_to new_member_path,
                    notice: "#{Member.full_names(@member.user_id)} is already a member of #{@group.name}"
      else

        invite_key = Digest::SHA1.hexdigest("#{DateTime.now}/#{@group.id}")
        invite = Invite.new(group_id: @group.id, invite_key: invite_key, max_redeem: 1,
                            invite_email: invite_email, user_id: current_user.id, total_redeemed: 0)

        if invite.save
          invite_id = Invite.find_by(invite_key: invite_key).id
          redeem = Redeem.new(invite_id: invite_id, user_id: @member.user_id, group_id: @group.id,
                              complete: 0)
          if redeem.save
            @member.invited_on = DateTime.now
            @member.status = 0
            @member.group_id = @group.id
            @member.invited_by = current_user.id

            if @member.save
              PrycelyMailer.new_group_email('accounts@prycely.com', invite_email,
                                            "You have been invited to #{@group.name}")
              redirect_to @member, notice: 'Member was successfully created.'
            else
              render json: @member
            end
          else
            render json: redeem.errors
          end
        else
          render json: invite.errors
        end
      end
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  def set_global_for_index
    @me = Member.where(user_id: current_user.id).where(group_id: @group.id).select(:designation)
  end

  # Only allow a list of trusted parameters through.
  def member_params
    params.require(:member).permit(:invited_by, :user_id, :group_id, :designation, :status, :invited_on, :accepted_on,
                                   :paid_member, :amount)
  end
end
