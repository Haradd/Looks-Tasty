class Review < ApplicationRecord
  belongs_to :recipe, counter_cache: true
  belongs_to :user, counter_cache: true

  after_create :update_reviews_average
  after_update :update_reviews_average
  after_destroy :update_reviews_average

  validates :rating, presence: true,
                     numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  validates :comment, length: { maximum: 100 }

  def update_reviews_average
    recipe = Recipe.find(recipe_id)
    average = recipe.reviews.sum(:rating).to_f / recipe.reviews_count.to_f
    recipe.update_attribute(:reviews_average, average.round(2))
    recipe.save
  end
end
