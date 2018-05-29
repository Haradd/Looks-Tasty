Types::ReviewType = GraphQL::ObjectType.define do
  name "Review"
  description "A Review"

  field :id, types.ID
  field :comment, types.String
  field :rating, types.Int
end
