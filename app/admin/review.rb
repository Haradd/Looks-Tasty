ActiveAdmin.register Review do
  permit_params :rating, :comment

  includes :user, :recipe

  index do
    selectable_column
    id_column
    column :user
    column :rating
    column :comment
    column :recipe
    column :created_at
    actions
  end
end
