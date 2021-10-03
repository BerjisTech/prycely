# frozen_string_literal: true

class ErrorsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_error, only: %i[show edit update destroy]

  # GET /errors or /errors.json
  def index
    stored_errors = Error.all

    stored_errors = Error.where(method: params['method']) if params['method'].present?

    errors = format_errors(stored_errors)

    render json: errors
  end

  def format_errors(stored_errors)
    errors = []
    stored_errors.map do |error|
      errors << {
        id: error.id,
        error: error.error, # JSON.parse(error.error),
        time: error.time,
        created_at: error.created_at,
        updated_at: error.updated_at,
        method: error.method,
        referer: error.referer,
        message: error.message
      }
    end
  end

  def clear
    Error.destroy_all
    render json: Error.all
  end

  # GET /errors/1 or /errors/1.json
  def show
    render json: @error
  end

  # GET /errors/new
  def new
    @error = Error.new
  end

  # GET /errors/1/edit
  def edit; end

  # POST /errors or /errors.json
  def create
    @error = Error.new(error_params)

    respond_to do |format|
      if @error.save
        format.html { redirect_to @error, notice: 'Error was successfully created.' }
        format.json { render :show, status: :created, location: @error }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @error.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /errors/1 or /errors/1.json
  def update
    respond_to do |format|
      if @error.update(error_params)
        format.html { redirect_to @error, notice: 'Error was successfully updated.' }
        format.json { render :show, status: :ok, location: @error }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @error.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /errors/1 or /errors/1.json
  def destroy
    @error.destroy
    respond_to do |format|
      format.html { redirect_to errors_url, notice: 'Error was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_error
    @error = Error.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def error_params
    params.require(:error).permit(:error, :time, :method, :referer)
  end
end
