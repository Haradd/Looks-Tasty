Types::RecipeType = GraphQL::ObjectType.define do
  name "Recipe"
  description "A Recipe"

  field :id, types.ID
  field :name, types.String
  field :description, types.String
  field :time, types.String
  field :tip, types.String

  field :category, types.String do
    resolve ->(recipe, args, ctx) {
      recipe.category.name
    }
  end

  field :reviews, types[Types::ReviewType] do
    argument :size, types.Int, default_value: 10
    resolve ->(recipe, args, ctx) {
      recipe.reviews.limit(args[:size])
    }
  end

  field :user, Types::UserType do
    resolve ->(recipe, args, ctx) {
      recipe.user
    }
  end

  field :steps, types[Types::StepType] do
    resolve ->(recipe, args, ctx) {
      recipe.steps
    }
  end

  field :ingredients, types[Types::IngredientType] do
    resolve ->(recipe, args, ctx) {
      recipe.ingredients
    }
  end
end
