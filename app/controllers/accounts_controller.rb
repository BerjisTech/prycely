class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: %i[ show edit update destroy ]
  # before_action :correct_user

  # GET /accounts or /accounts.json
  def index
    # @accounts = Account.all.with_attached_image
    @accounts = current_user.accounts
  end

  # GET /accounts/1 or /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    # @account = Account.new
    @account = current_user.accounts.build
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    # @account = Account.new(account_params)
    @account = current_user.accounts.build(account_params)

    @account.image.attach(params[:account][:image])

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: "Account was successfully created." }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
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
    @user = current_user.accounts.find_by(user_id: params[:id])
    redirect_to accounts_path, notice: "You're not authorized to perform this action" if @user.nil?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(current_user.id)
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:user_id, :phone, :first_name, :last_name, :photo, :deactivated, :verified, :country, :county, :city, :street, :address, :postal, :account_type, :tour, :image)
  end
end
