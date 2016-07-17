FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.word }
  end
end
