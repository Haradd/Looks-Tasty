ActiveAdmin.register Step do
  belongs_to :recipe

  permit_params :step

  index do
    column :step
    column :created_at
    column :updated_at
    actions
  end
end
