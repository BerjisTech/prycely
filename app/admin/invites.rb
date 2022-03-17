# frozen_string_literal: true

ActiveAdmin.register Invite do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :group_id, :invite_key, :max_redeem, :invite_email, :active, :total_redeemed, :user_id
  #
  # or
  #
  permit_params do
    permitted = %i[group_id invite_key max_redeem invite_email active total_redeemed user_id]
    permitted << :other if params[:action] == 'create' && current_user.try(:admin?)
    permitted
  end
end
