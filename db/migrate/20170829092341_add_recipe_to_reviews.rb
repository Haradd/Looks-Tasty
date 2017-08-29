class AddRecipeToReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :recipe, index: true
    add_foreign_key :reviews, :recipes
  end
end
