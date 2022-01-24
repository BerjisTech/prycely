# frozen_string_literal: true

ActiveAdmin.register GroupAsset do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :group_id, :date_bought, :date_sold, :added_by, :price
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :group_id, :date_bought, :date_sold, :added_by, :price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |form|
    form.label :group_id
    form.select(:group_id, options_from_collection_for_select(Group.all, :id, :name), {},
                { class: 'user_field form-control', placeholder: 'Placeholder', required: 'required', style: 'width: 100%; border: 1px solid #c9d0d6; height: 28px; background: #ffffff;' })
    form.hidden_field :added_by, value: current_user.id
    form.label :name
    form.text_field :name
    form.label :price
    form.number_field :price
    form.label :date_bought
    form.date_field :date_bought
    form.label :date_sold
    form.date_field :date_sold
    form.label :description
    form.rich_text_area :description

    form.submit 'Save Asset'
  end
end
