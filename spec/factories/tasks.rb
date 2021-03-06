FactoryGirl.define do
  factory :task do
    name { Faker::Lorem.sentence(4, true, 2) }
    deadline { Faker::Date.forward(90) }
    completed { Faker::Boolean.boolean }
    project

    factory :invalid_task do
      name ''
    end
  end
end
