ActiveAdmin.register User do
  permit_params :username, :email, :password

  index do
    selectable_column
    id_column
    column :username
    column :email
    actions
  end

  form do |_f|
    inputs "Add new user" do
      input :username
      input :email
      input :password
    end
    para "Press cancel to return to the list without saving."
    actions
  end
end
