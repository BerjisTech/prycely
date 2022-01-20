# frozen_string_literal: true

ActiveAdmin.register Stk do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :transaction_reference, :merchant_request_id, :checkout_request_id, :response_code, :response_description, :custom_message, :status, :response_result_code, :response_result_description, :phone
  #
  # or
  #
  # permit_params do
  #   permitted = [:transaction_reference, :merchant_request_id, :checkout_request_id, :response_code, :response_description, :custom_message, :status, :response_result_code, :response_result_description, :phone]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
