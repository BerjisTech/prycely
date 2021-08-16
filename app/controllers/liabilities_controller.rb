# frozen_string_literal: true

class LiabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_liability, only: %i[show edit update destroy]

  # GET /liabilities or /liabilities.json
  def index
    @liabilities = Liability.all
  end

  # GET /liabilities/1 or /liabilities/1.json
  def show; end

  # GET /liabilities/new
  def new
    @liability = Liability.new
  end

  # GET /liabilities/1/edit
  def edit; end

  # POST /liabilities or /liabilities.json
  def create
    @liability = Liability.new(liability_params)

    respond_to do |format|
      if @liability.save
        format.html { redirect_to @liability, notice: "Liability was successfully created." }
        format.json { render :show, status: :created, location: @liability }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @liability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /liabilities/1 or /liabilities/1.json
  def update
    respond_to do |format|
      if @liability.update(liability_params)
        format.html { redirect_to @liability, notice: "Liability was successfully updated." }
        format.json { render :show, status: :ok, location: @liability }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @liability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /liabilities/1 or /liabilities/1.json
  def destroy
    @liability.destroy
    respond_to do |format|
      format.html { redirect_to liabilities_url, notice: "Liability was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_liability
    @liability = Liability.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def liability_params
    params.require(:liability).permit(:name, :description, :group_id, :date_bought, :date_sold, :added_by, :price)
  end
end
