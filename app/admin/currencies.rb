# frozen_string_literal: true

ActiveAdmin.register Currency do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :currency, :code, :country, :country_code
  #
  # or
  #
  permit_params do
    permitted = %i[currency code country country_code]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
