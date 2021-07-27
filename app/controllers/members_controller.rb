class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_member, only: %i[ show edit update destroy ]
  before_action :set_global_for_index, only: %i[ index ]
  before_action :set_global
  before_action :check_group_session, only: %i[ index ]

  # GET /members or /members.json
  def index
    @members = Member.where(group_id: session[:current_group]).joins(:user => :accounts).limit(10).select(:first_name, :last_name, :email, :group_id, :user_id, :id, :invited_on, :accepted_on, :invited_by, :designation)
    # render json: @me
  end

  # GET /members/1 or /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)

    # render json: @member

    respond_to do |format|

      check_member_in_system(@member.designation, format)

      check_member_in_group(@member.user_id)

      @member.invited_on = DateTime.now
      @member.status = 0
      @member.designation = "member"

      # Generate new invite with email
      # Save member
      # Generate new redeem
      # Update redeem to used (if need be)
      # Update invite to maxed out 

      if @member.save
        format.html { redirect_to @member, notice: "Member was successfully created." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: "Member was successfully updated." }
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
      format.html { redirect_to members_url, notice: "Member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  def check_group_session
    if session[:current_group]
    else
      redirect_to groups_path, notice: "You need to access a group first to see it's members"
    end
  end

  def set_global
    @group = Group.find(session[:current_group])
  end

  def set_global_for_index
    @me = Member.where(user_id: current_user.id).where(group_id: session[:current_group]).select(:designation)
  end

  def check_member_in_group(user)
    @check = Member.where(user_id: user).where(group_id: session[:current_group])
    if @check.count > 0
      redirect_to new_member_path, notice: "This member already exists in " + @group.name
    end
  end

  def check_member_in_system(user, format)
    @check = User.find_by(email: user)

    if @check.nil?
      format.html { redirect_to new_invite_path, alert: "This member does not exist in our records. Would you like to send them an invite link to join " + @group.name }
      format.json { render :show, status: :created, location: @member }
    else
      @member.user_id = @check.id
    end
  end

  # Only allow a list of trusted parameters through.
  def member_params
    params.require(:member).permit(:invited_by, :user_id, :group_id, :designation, :status, :invited_on, :accepted_on, :paid_member, :amount)
  end
end
