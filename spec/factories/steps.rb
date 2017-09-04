FactoryGirl.define do
  factory :step do
    recipe
    name { FFaker::Lorem.sentence }
  end
end
