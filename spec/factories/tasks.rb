FactoryGirl.define do
  factory :task do
    name { Faker::Lorem.sentence(4, true, 2) }
    deadline { Faker::Date.forward(90) }
    status { Faker::Boolean.boolean }
    project
  end
end
