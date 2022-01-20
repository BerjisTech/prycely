# frozen_string_literal: true

ActiveAdmin.register Loancategory do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :group_id, :created_by, :name, :period, :decsription, :amount, :interest, :interest_rule, :required_guarantos, :requirements, :pegged_to, :membership_durantion_requirement, :approvals
  #
  # or
  #
  permit_params do
    permitted = [:group_id, :created_by, :name, :period, :decsription, :amount, :interest, :interest_rule, :required_guarantos, :requirements, :pegged_to, :membership_durantion_requirement, :approvals]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
