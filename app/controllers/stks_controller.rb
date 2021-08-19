# frozen_string_literal: true

class StksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stk, only: %i[show edit update destroy]

  # GET /stks or /stks.json
  def index
    @stks = Stk.all
  end

  # GET /stks/1 or /stks/1.json
  def show; end

  # GET /stks/new
  def new
    @stk = Stk.new
  end

  # GET /stks/1/edit
  def edit; end

  # POST /stks or /stks.json
  def create
    @stk = Stk.new(stk_params)

    respond_to do |format|
      if @stk.save
        format.html { redirect_to @stk, notice: 'Stk was successfully created.' }
        format.json { render :show, status: :created, location: @stk }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stks/1 or /stks/1.json
  def update
    respond_to do |format|
      if @stk.update(stk_params)
        format.html { redirect_to @stk, notice: 'Stk was successfully updated.' }
        format.json { render :show, status: :ok, location: @stk }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stks/1 or /stks/1.json
  def destroy
    @stk.destroy
    respond_to do |format|
      format.html { redirect_to stks_url, notice: 'Stk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stk
    @stk = Stk.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def stk_params
    params.require(:stk).permit(:transaction_reference, :merchant_request_id, :checkout_request_id, :response_code,
                                :response_description, :custom_message, :status, :response_result_code, :response_result_description, :phone)
  end
end
