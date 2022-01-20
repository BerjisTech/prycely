# frozen_string_literal: true

ActiveAdmin.register Group do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :created_by, :currency, :group_type, :membership, :name, :description, :requirements
  #
  # or
  #
  # permit_params do
  #   permitted = [:created_by, :currency, :group_type, :membership, :name, :description, :requirements]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |form|
    form.number_field :created_by, value: current_user.id, type: :hidden

    form.label :name, style: "display: block;"
    form.text_field :name, class: 'form-control form-control-sm', required: 'required', style: "display: block; margin-bottom: 10px;"

    form.label :currency, style: "display: block;"
    form.currency_select(:currency, {}, { include_blank: 'Select Group Currency' },
                         { class: 'form-control', required: 'required', style: "display: block; margin-bottom: 10px;" })

    form.label :group_type, style: "display: block;"
    form.select :group_type, [
      ['Freinds & Family Groups', '1'],
      ['Temporary Or Mid sized (Church, Fundraisers etc)', '2'],
      ['Sacco & Co-operative', '3'],
      ['Wash Wash', '4']
    ], { prompt: 'Choose Group Type' }, class: 'form-control form-select', required: 'required', style: "display: block; margin-bottom: 10px;"

    form.label :membership, style: "display: block;"
    form.number_field :membership, class: 'form-control', required: 'required', value: 0, step: '0.01', style: "display: block; margin-bottom: 10px;"

    form.submit
  end
end
