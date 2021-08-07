# frozen_string_literal: true

class PaymentcategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_paymentcategory, only: %i[show edit update destroy]

  # GET /paymentcategories or /paymentcategories.json
  def index
    @paymentcategories = Paymentcategory.all
  end

  # GET /paymentcategories/1 or /paymentcategories/1.json
  def show; end

  # GET /paymentcategories/new
  def new
    @paymentcategory = Paymentcategory.new
  end

  # GET /paymentcategories/1/edit
  def edit; end

  # POST /paymentcategories or /paymentcategories.json
  def create
    @paymentcategory = Paymentcategory.new(paymentcategory_params)

    respond_to do |format|
      if @paymentcategory.save
        format.html { redirect_to @paymentcategory, notice: 'Paymentcategory was successfully created.' }
        format.json { render :show, status: :created, location: @paymentcategory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @paymentcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paymentcategories/1 or /paymentcategories/1.json
  def update
    respond_to do |format|
      if @paymentcategory.update(paymentcategory_params)
        format.html { redirect_to @paymentcategory, notice: 'Paymentcategory was successfully updated.' }
        format.json { render :show, status: :ok, location: @paymentcategory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @paymentcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paymentcategories/1 or /paymentcategories/1.json
  def destroy
    @paymentcategory.destroy
    respond_to do |format|
      format.html { redirect_to paymentcategories_url, notice: 'Paymentcategory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_paymentcategory
    @paymentcategory = Paymentcategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def paymentcategory_params
    params.require(:paymentcategory).permit(:group_id, :created_by, :payment_category_type, :name)
  end
end
