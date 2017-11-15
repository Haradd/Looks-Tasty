ActiveAdmin.register Ingredient do
  belongs_to :recipe

  permit_params :name

  index do
    column :name
    column :created_at
    column :updated_at
    actions
  end
end
