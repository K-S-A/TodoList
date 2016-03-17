FactoryGirl.define do
  factory :project do
    title { Faker::Lorem.sentence(4, true, 2) }
    description { Faker::Lorem.sentence }
    user
  end
end
