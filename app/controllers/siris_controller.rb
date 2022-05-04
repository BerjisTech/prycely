# frozen_string_literal: true

class SirisController < ApplicationController
  before_action :authenticate_user!
  before_action :set_siri, only: %i[show edit update destroy]

  # GET /siris or /siris.json
  def _index
    @siris = Siri.all
  end

  # GET /siris/1 or /siris/1.json
  def _show; end

  # GET /siris/new
  def _new
    @siri = Siri.new
  end

  # GET /siris/1/edit
  def _edit; end

  # POST /siris or /siris.json
  def _create
    @siri = Siri.new(siri_params)

    respond_to do |format|
      if @siri.save
        format.html { redirect_to @siri, notice: 'Siri was successfully created.' }
        format.json { render :show, status: :created, location: @siri }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @siri.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /siris/1 or /siris/1.json
  def _update
    respond_to do |format|
      if @siri.update(siri_params)
        format.html { redirect_to @siri, notice: 'Siri was successfully updated.' }
        format.json { render :show, status: :ok, location: @siri }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @siri.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /siris/1 or /siris/1.json
  def _destroy
    @siri.destroy
    respond_to do |format|
      format.html { redirect_to siris_url, notice: 'Siri was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_siri
    @siri = Siri.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def siri_params
    params.require(:siri).permit(:name, :value)
  end
end
