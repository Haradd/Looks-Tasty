FactoryBot.define do
  factory :ingredient do
    recipe
    name { FFaker::Lorem.words(rand(1..4)).join(" ") }
  end
end
