FactoryGirl.define do
  factory :project do
    title { Faker::Lorem.sentence(3, true, 2) }
    description { Faker::Lorem.sentence }
    user

    factory :invalid_project do
      title 'New'
    end
  end
end
