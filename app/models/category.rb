class Category < ApplicationRecord
  has_many :recipes

  validates :name, presence: true,
                   inclusion: ["Appetizers & Snacks", "Breakfast & Brunch", "Dinner", "Desserts", "Drinks"]

  def self.all_cached
    Rails.cache.fetch('categories') do
      Category.all.to_a
    end
  end
end
