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
  end
end
