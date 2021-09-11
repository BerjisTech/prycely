# frozen_string_literal: true

class ErrorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_error, only: %i[show edit update destroy]

  # GET /errors or /errors.json
  def index
    # errors = []

    stored_errors = Error.all

    # if params.method.present?
    #   stored_errors = Error.where(method: params[:method])
    # end

    # stored_errors.map do |error|
    #   row = error.error.gsub('=>', ':')
    #   errors << JSON.parse(row)
    # end

    render json: stored_errors
  end

  def clear
    Error.destroy_all
    render json: Error.all
  end

  # GET /errors/1 or /errors/1.json
  def show; end

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
