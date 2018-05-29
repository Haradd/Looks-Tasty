Types::StepType = GraphQL::ObjectType.define do
 name "Step"
  description "A step"

  field :id, types.ID
  field :step, types.String
  
end
