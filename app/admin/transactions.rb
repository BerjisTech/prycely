# frozen_string_literal: true

ActiveAdmin.register Transaction do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :amount, :transaction_reference, :transaction_type, :group_id, :wallet_id, :status, :transaction_mode, :description, :category, :sub_category, :currency, :level
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :amount, :transaction_reference, :transaction_type, :group_id, :wallet_id, :status, :transaction_mode, :description, :category, :sub_category, :currency, :level]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
