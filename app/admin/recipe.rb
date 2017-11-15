ActiveAdmin.register Recipe do
  decorate_with RecipeDecorator

  includes :user, :reviews

  permit_params :name, :description, :image, :time, :tip, :portions, :category_id,
                ingredients_attributes: %i[id name _destroy],
                steps_attributes: %i[id step _destroy]

  index do
    selectable_column
    id_column
    column :name
    column :average_review
    column :reviews_count
    column :user
    actions
  end


  sidebar "Recipe Content", only: [:show, :edit] do
    ul do
      li link_to "Steps", admin_recipe_steps_path(resource)
      li link_to "Ingredients", admin_recipe_ingredients_path(resource)
    end
  end

end
