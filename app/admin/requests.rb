# frozen_string_literal: true

ActiveAdmin.register Request do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :group_id, :user_id, :account_id, :emai, :accept
  #
  # or
  #
  permit_params do
    permitted = %i[group_id user_id account_id emai accept]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
