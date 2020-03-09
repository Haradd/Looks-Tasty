FactoryBot.define do
  factory :review do
    recipe
    user

    rating { rand(3..5) }
    comment { FFaker::Lorem.sentence }
  end
end
