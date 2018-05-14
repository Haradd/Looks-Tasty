class RecipeSerializer < ActiveModel::Serializer
  attributes :name, :description, :category, :portions, :tip, :time,
      :ingredients, :steps, :image, :reviews_count, :reviews_average

  belongs_to :user
  has_many :reviews

  def category
    object.category.name
  end

  def ingredients
    object.ingredients.pluck(:name)
  end

  def steps
    steps_array = object.steps.pluck(:id, :step)
    steps_array.inject([]) { |result, elem| result << { id: elem[0], step: elem[1] } }
  end

  def cache_key
    [object, scope]
  end
end
