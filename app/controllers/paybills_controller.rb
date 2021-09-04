# frozen_string_literal: true

class PaybillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paybill, only: %i[show edit update destroy]

  # GET /paybills or /paybills.json
  def index
    @paybills = Paybill.all
  end

  # GET /paybills/1 or /paybills/1.json
  def show; end

  # GET /paybills/new
  def new
    @paybill = Paybill.new
  end

  # GET /paybills/1/edit
  def edit; end

  # POST /paybills or /paybills.json
  def create
    @paybill = Paybill.new(paybill_params)

    respond_to do |format|
      if @paybill.save
        format.html { redirect_to @paybill, notice: "Paybill was successfully created." }
        format.json { render :show, status: :created, location: @paybill }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @paybill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paybills/1 or /paybills/1.json
  def update
    respond_to do |format|
      if @paybill.update(paybill_params)
        format.html { redirect_to @paybill, notice: "Paybill was successfully updated." }
        format.json { render :show, status: :ok, location: @paybill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @paybill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paybills/1 or /paybills/1.json
  def destroy
    @paybill.destroy
    respond_to do |format|
      format.html { redirect_to paybills_url, notice: "Paybill was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_paybill
    @paybill = Paybill.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def paybill_params
    params.require(:paybill).permit(:request, :paybill_type, :transaction_reference, :paybill_balance,
                                    :third_party_transaction_id, :invoice_number, :amount, :first_name, :last_name, :middle_name, :phone, :short_code, :account_number)
  end
end
