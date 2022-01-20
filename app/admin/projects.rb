# frozen_string_literal: true

ActiveAdmin.register Project do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :amount, :status, :project_start, :project_end, :created_by, :group_id, :currency
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :amount, :status, :project_start, :project_end, :created_by, :group_id, :currency]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
