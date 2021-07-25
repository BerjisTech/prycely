class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[ show members edit update destroy ]

  # GET /groups or /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1 or /groups/1.json
  def show
    @account_check = Member.where(group_id: @group.id)
    if (@account_check.count == 0 || @account_check.length == 0 || @account_check.empty? || @account_check == nil)
      if current_user.id == @group.created_by
        @admin_account = Member.new(:invited_by => current_user.id, :user_id => current_user.id, :group_id => params[:id], :designation => "admin", :status => "1", :invited_on => DateTime.now, :accepted_on => DateTime.now, :paid_member => "", :amount => 0, :account_id => @account[0])

        if @admin_account.save
          respond_to do |format|
            format.html { redirect_to group_url(params[:id]), notice: "Your admin account has succsefully been set up" }
            format.json { head :no_content }
          end
        else
          render json: @admin_account.errors
        end
      end
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
    @currency = Currency.all
  end

  # GET /groups/1/members
  def members
    # @group = Group.where(id: params[:id])
    @members = Member.where(group_id: params[:id]).joins(:user => :accounts).limit(10).select(:first_name, :last_name, :email, :group_id, :user_id, :id, :invited_on, :accepted_on, :invited_by, :designation)
    # render json: @me
  end

  def transactions
  end

  def projects
  end

  def activities
  end

  def loans
  end

  def income
  end

  def assets
  end

  def liabilities
  end

  # GET /groups/1/edit
  def edit
  end

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
    @me = Member.where(user_id: current_user.id).where(group_id: params[:id]).select(:designation)
    @account = Account.where(user_id: current_user.id).pluck(:id)
    session[:current_group] = @group.id
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:created_by, :name, :currency, :group_type, :membership)
  end
end
