# frozen_string_literal: true

ActiveAdmin.register Loan do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :group_id, :created_by, :user_id, :amount, :loan_type, :amount_due, :interest, :status, :guarantors, :date_granted, :date_due, :date_paid, :requirements, :ammount_paid
  #
  # or
  #
  # permit_params do
  #   permitted = [:group_id, :created_by, :user_id, :amount, :loan_type, :amount_due, :interest, :status, :guarantors, :date_granted, :date_due, :date_paid, :requirements, :ammount_paid]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
