# frozen_string_literal: true

class LoancategoriesController < ApplicationController
  before_action :has_active_group?
  before_action :authenticate_user!
  before_action :set_loancategory, only: %i[show edit update destroy]

  # GET /loancategories or /loancategories.json
  def index
    @loancategories = Loancategory.all
  end

  # GET /loancategories/1 or /loancategories/1.json
  def show; end

  # GET /loancategories/new
  def new
    @loancategory = Loancategory.new
  end

  # GET /loancategories/1/edit
  def edit; end

  # POST /loancategories or /loancategories.json
  def create
    @loancategory = Loancategory.new(loancategory_params)

    respond_to do |format|
      if @loancategory.save
        format.html { redirect_to @loancategory, notice: 'Loancategory was successfully created.' }
        format.json { render :show, status: :created, location: @loancategory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loancategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loancategories/1 or /loancategories/1.json
  def update
    respond_to do |format|
      if @loancategory.update(loancategory_params)
        format.html { redirect_to @loancategory, notice: 'Loancategory was successfully updated.' }
        format.json { render :show, status: :ok, location: @loancategory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loancategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loancategories/1 or /loancategories/1.json
  def destroy
    @loancategory.destroy
    respond_to do |format|
      format.html { redirect_to loancategories_url, notice: 'Loancategory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_loancategory
    @loancategory = Loancategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def loancategory_params
    params.require(:loancategory).permit(:group_id, :created_by, :name, :period, :decsription, :pegged_to, :amount, :interest,
                                         :interest_rule, :required_guarantos, :membership_durantion_requirement, :requirements)
  end
end
