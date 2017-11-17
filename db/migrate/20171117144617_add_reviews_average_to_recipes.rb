class AddReviewsAverageToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :reviews_average, :float, default: 0
  end
end
