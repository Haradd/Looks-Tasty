class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :comment, :rating, :user_id, :recipe_id

end
