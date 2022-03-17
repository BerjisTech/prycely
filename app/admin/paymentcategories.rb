# frozen_string_literal: true

ActiveAdmin.register Paymentcategory do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :group_id, :created_by, :payment_category_type, :name
  #
  # or
  #
  permit_params do
    permitted = %i[group_id created_by payment_category_type name]
    permitted << :other if params[:action] == 'create' && current_user.try(:admin?)
    permitted
  end
end
