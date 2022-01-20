# frozen_string_literal: true

ActiveAdmin.register Activity do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :date, :created_by, :group_id, :price, :fine, :host, :host_contact
  #
  # or
  #
  permit_params do
    permitted = [:title, :description, :date, :created_by, :group_id, :price, :fine, :host, :host_contact]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
