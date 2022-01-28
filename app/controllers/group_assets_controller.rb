class GroupAssetsController < ApplicationController
  before_action :set_group_asset, only: %i[ show edit update destroy ]
  before_action :has_active_group?, except: :index
  before_action :set_group_by_session

  # GET /group_assets or /group_assets.json
  def index
    @group_assets = GroupAsset.all
  end

  # GET /group_assets/1 or /group_assets/1.json
  def show
  end

  # GET /group_assets/new
  def new
    @group_asset = GroupAsset.new
  end

  # GET /group_assets/1/edit
  def edit
  end

  def group; end

  # POST /group_assets or /group_assets.json
  def create
    @group_asset = GroupAsset.new(group_asset_params)

    respond_to do |format|
      if @group_asset.save
        format.html { redirect_to group_asset_url(@group_asset), notice: "Group asset was successfully created." }
        format.json { render :show, status: :created, location: @group_asset }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_assets/1 or /group_assets/1.json
  def update
    respond_to do |format|
      if @group_asset.update(group_asset_params)
        format.html { redirect_to group_asset_url(@group_asset), notice: "Group asset was successfully updated." }
        format.json { render :show, status: :ok, location: @group_asset }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_assets/1 or /group_assets/1.json
  def destroy
    @group_asset.destroy

    respond_to do |format|
      format.html { redirect_to group_assets_url, notice: "Group asset was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_asset
      @group_asset = GroupAsset.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_asset_params
      params.require(:group_asset).permit(:name, :description, :group_id, :date_bought, :date_sold, :user_id, :price)
    end
end
