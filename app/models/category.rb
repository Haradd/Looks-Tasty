class Category < ApplicationRecord
  has_many :recipes

  validates :name, presence: true,
    inclusion: ["Appetizers & Snacks", "Breakfast & Brunch", "Dinner", "Desserts", "Drinks"]
end
