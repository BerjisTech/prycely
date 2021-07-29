class RedeemsController < ApplicationController
  before_action :set_redeem, only: %i[ show edit update destroy ]

  # GET /redeems or /redeems.json
  def index
    @redeems = Redeem.where(user_id: current_user.id)
  end

  def redeem
    @redeem = Invite.where(invite_key: @invite_key).joins(:group).joins(:user => :accounts).select("invites.id", :first_name, :name, :email, :group_id, :group_type, :description)

    if (@redeem.length == 0 || @redeem == "null" || @redeem.empty?)
      respond_to do |format|
        format.html { redirect_to root_path, notice: "This invite link is either expired or doesn't exist." }
        format.json { render :show, status: :created, location: @redeem }
      end
    else
      @invite = @redeem[0]

      if @invite.group_type == "1"
        @grouptype = "Friends and Family"
      elsif @invite.group_type == "2"
        @grouptype = "Temporary or Mid-sized (Church, Fundraiser etc)"
      elsif @invite.group_type == "3"
        @grouptype = "Cooperative & Saccos"
      else
        @grouptype = "Wash Wash"
      end

      # render json: @redeem
    end
  end

  def accept_invite
    @invite_key = session[:invite_key]
    @invite = Invite.find_by(invite_key: @invite_key)
    Invite.where(invite_key: @invite_key).update_all(total_redeemed: 1)
    Member.where(group_id: session[:current_group]).where(user_id: current_user.id).update_all(status: "1")
    Redeem.where(invite_id: @invite_key).update_all(complete: 1)
    @group = Group.find(session[:current_group])
    redirect_to @group, notice: "You have succesfully joined " + @group.name
  end

  # GET /redeems/1 or /redeems/1.json
  def show
  end

  # GET /redeems/new
  def new
    @redeem = Redeem.new
  end

  # GET /redeems/1/edit
  def edit
  end

  # POST /redeems or /redeems.json
  def create
    @redeem = Redeem.new(redeem_params)

    respond_to do |format|
      if @redeem.save
        format.html { redirect_to @redeem, notice: "Redeem was successfully created." }
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
        format.html { redirect_to @redeem, notice: "Redeem was successfully updated." }
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
      format.html { redirect_to redeems_url, notice: "Redeem was successfully destroyed." }
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
