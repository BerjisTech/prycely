# frozen_string_literal: true

ActiveAdmin.register Account do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :phone, :first_name, :last_name, :photo, :deactivated, :verified, :country, :county, :city, :street, :address, :postal, :account_type, :tour, :default_currency
  #
  # or
  #
  permit_params do
    permitted = %i[user_id phone first_name last_name photo deactivated verified country county city
                   street address postal account_type tour default_currency]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
