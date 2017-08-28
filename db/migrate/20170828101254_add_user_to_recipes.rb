class AddUserToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_reference :recipes, :user, index: true
    add_foreign_key :recipes, :users
  end
end
