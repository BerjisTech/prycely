# frozen_string_literal: true

class WalletsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wallet, only: %i[show edit update destroy]

  # GET /wallets or /wallets.json
  def index
    # @wallets = Wallet.all
    @wallets = current_user.wallets
  end

  # GET /wallets/1 or /wallets/1.json
  def show; end

  # GET /wallets/new
  def new
    # @wallet = Wallet.new
    @wallet = current_user.wallets.build
  end

  # GET /wallets/1/edit
  def edit
    redirect_to wallet_path(params[:id])
  end

  # POST /wallets or /wallets.json
  def create
    # @wallet = Wallet.new(wallet_params)
    @wallet = current_user.wallets.build(wallet_params)

    check_id = Wallet.find_by(user_id: current_user.id, currency: @wallet.currency).id

    message = "You already have a #{@wallet.currency} wallet"

    if check_id.blank?
      respond_to do |format|
        if @wallet.save
          format.html { redirect_to @wallet, notice: 'Wallet was successfully created.' }
          format.json { render :show, status: :created, location: @wallet }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @wallet.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to wallet_path(check_id), notice: message
    end
  end

  # PATCH/PUT /wallets/1 or /wallets/1.json
  def update
    respond_to do |format|
      if @wallet.update(wallet_params)
        format.html { redirect_to @wallet, notice: 'Wallet was successfully updated.' }
        format.json { render :show, status: :ok, location: @wallet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallets/1 or /wallets/1.json
  def destroy
    @wallet.destroy
    respond_to do |format|
      format.html { redirect_to wallets_url, notice: 'Wallet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def correct_user
    @user = current_user.wallets.find_by(id: params[:id])
    redirect_to wallets_path, notice: "You're not authorized to perform this action" if @user.nil?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_wallet
    @wallet = Wallet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def wallet_params
    params.require(:wallet).permit(:user_id, :currency)
  end
end
