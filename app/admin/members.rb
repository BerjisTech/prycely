# frozen_string_literal: true

ActiveAdmin.register Member do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :invited_by, :user_id, :group_id, :designation, :status, :invited_on, :accepted_on, :paid_member, :amount, :account_id
  #
  # or
  #
  permit_params do
    permitted = [:invited_by, :user_id, :group_id, :designation, :status, :invited_on, :accepted_on, :paid_member, :amount, :account_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
