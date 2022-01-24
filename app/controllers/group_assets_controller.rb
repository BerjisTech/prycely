# frozen_string_literal: true

class GroupAssetsController < InheritedResources::Base
  before_action :set_group_by_session
  
  def group
    
  end

  private

  def group_asset_params
    params.require(:group_asset).permit(:name, :description, :group_id, :date_bought, :date_sold, :added_by, :price)
  end
end
