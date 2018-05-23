class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :reviews_count
end
