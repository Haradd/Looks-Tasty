FactoryGirl.define do
  factory :recipe do
    user
    category

    name { FFaker::Lorem.words(rand(3..6)).join(" ") }
    description { FFaker::Lorem.sentence }
    image { FFaker::Avatar.image }
    tip { FFaker::Lorem.sentence }
    portions { rand(1..6) }
    time { FFaker::Time.datetime }

    before(:create) do |recipe|
      recipe.steps << FactoryGirl.build(:step, recipe: recipe)
      recipe.ingredients << FactoryGirl.build(:ingredient, recipe: recipe)
    end
  end
end
