class AddReviewsCountToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :reviews_count, :integer, default: 0
  end
end
