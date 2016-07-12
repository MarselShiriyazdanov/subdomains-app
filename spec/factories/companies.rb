FactoryGirl.define do
  factory :company do
    name { Faker::Internet.domain_word }
  end
end
