class Review < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  validates :rating, presence: true,
                     numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5,
                                    message: "" }

  validates :comment, length: { maximum: 100 }
end
