FactoryGirl.define do
  factory :recipe do
    user
    category

    name { FFaker::Lorem.words(rand(3..6)).join(" ") }
    description { FFaker::Lorem.sentence }
    tip { FFaker::Lorem.sentence }
    portion { rand(1..6) }
    time { FFaker::Time.datetime }
  end
end
