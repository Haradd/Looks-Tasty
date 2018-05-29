Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  description "The query root for this schema"

  field :recipes, types[Types::RecipeType] do
    description "Retrieve a list of all recipes"
    argument :sort, types.String
    argument :search, types.String
    argument :category, types.String
    resolve ->(obj, args, ctx) {
      Recipe.filter(args)
    }
  end

  field :recipe, Types::RecipeType do
    argument :id, !types.ID
    resolve ->(obj, args, ctx) {
      Recipe.find(args[:id])
    }
  end

  field :review, Types::ReviewType do
    argument :id, !types.ID
    resolve ->(obj, args, ctx) {
      Review.find(args[:id])
    }
  end

  field :reviews, types[Types::ReviewType] do
    description "Retrieve a list of all reviews"
    resolve ->(obj, args, ctx) {
      Review.all
    }
  end

  field :user, Types::UserType do
    argument :id, !types.ID
    resolve ->(obj, args, ctx) {
      User.find(args[:id])
    }
  end

  field :users, types[Types::UserType] do
    description "Retrieve a list of all users"
    resolve ->(obj, args, ctx) {
      User.all
    }
  end
end
