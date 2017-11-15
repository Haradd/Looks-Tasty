class Review < ApplicationRecord
  belongs_to :recipe, counter_cache: true
  belongs_to :user, counter_cache: true

  validates :rating, presence: true,
                     numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  validates :comment, length: { maximum: 100 }
end
