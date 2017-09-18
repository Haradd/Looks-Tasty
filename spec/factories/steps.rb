FactoryGirl.define do
  factory :step do
    recipe
    step { FFaker::Lorem.sentence }
  end
end
