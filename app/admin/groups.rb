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
  permit_params do
    permitted = %i[created_by currency group_type membership name description requirements]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  form do |form|
    div do
      div style: 'display: inline-table;' do
        form.label :name
        form.text_field :name, required: 'required', style: 'width: 100%;'
        form.text_field :created_by, value: current_user.id, type: :hidden, class: 'form-control'
      end

      div style: 'display: inline-table;' do
        form.label :currency
        form.currency_select(:currency, {}, { include_blank: 'Select Group Currency' },
                             { class: 'form-control', required: 'required', style: 'width: 100%; border: 1px solid #c9d0d6; height: 28px; background: #ffffff;' })
      end

      div style: 'display: inline-table;' do
        form.label :group_type
        form.select(:group_type, options_from_collection_for_select(Grouptype.all, :id, :name), {},
                    { class: 'user_field form-control', placeholder: 'Placeholder', required: 'required', style: 'width: 100%; border: 1px solid #c9d0d6; height: 28px; background: #ffffff;' })
      end

      div style: 'display: inline-table;' do
        form.label :membership
        form.number_field :membership, class: 'form-control', required: 'required', value: 0, step: '0.01',
                                       style: 'width: 100%; margin-bottom: 10px;'
      end
    end

    form.submit
  end
end
