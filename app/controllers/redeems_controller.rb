class RedeemsController < ApplicationController
  before_action :set_redeem, only: %i[ show edit update destroy ]

  # GET /redeems or /redeems.json
  def index
    @redeems = Redeem.all
  end

  # GET /redeems/1 or /redeems/1.json
  def show
  end

  # GET /redeems/new
  def new
    @redeem = Redeem.new
  end

  # GET /redeems/1/edit
  def edit
  end

  # POST /redeems or /redeems.json
  def create
    @redeem = Redeem.new(redeem_params)

    respond_to do |format|
      if @redeem.save
        format.html { redirect_to @redeem, notice: "Redeem was successfully created." }
        format.json { render :show, status: :created, location: @redeem }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @redeem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /redeems/1 or /redeems/1.json
  def update
    respond_to do |format|
      if @redeem.update(redeem_params)
        format.html { redirect_to @redeem, notice: "Redeem was successfully updated." }
        format.json { render :show, status: :ok, location: @redeem }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @redeem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /redeems/1 or /redeems/1.json
  def destroy
    @redeem.destroy
    respond_to do |format|
      format.html { redirect_to redeems_url, notice: "Redeem was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_redeem
      @redeem = Redeem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def redeem_params
      params.require(:redeem).permit(:invite_id)
    end
end
