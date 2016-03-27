FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.sentence(2, true, 2) }
    file_link { Faker::Internet.url }
    task

    factory :invalid_comment do
      body ''
    end
  end
end
