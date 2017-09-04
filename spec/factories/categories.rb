FactoryGirl.define do
  factory :category do
    name { ["Appetizers & Snacks", "Breakfast & Brunch", "Dinner", "Desserts", "Drinks"].sample }
  end
end
