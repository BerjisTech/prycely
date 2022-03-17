# frozen_string_literal: true

ActiveAdmin.register GroupAsset do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :group_id, :date_bought, :date_sold, :user_id, :price
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :group_id, :date_bought, :date_sold, :user_id, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.try(:admin?)
  #   permitted
  # end
end
