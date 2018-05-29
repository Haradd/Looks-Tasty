Types::IngredientType = GraphQL::ObjectType.define do
  name "Ingredient"
  description "A ingredient"

  field :id, types.ID
  field :name, types.String
end
