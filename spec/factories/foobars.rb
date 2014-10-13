
FactoryGirl.define do
  factory :foobar do
    name { Faker::Lorem.word }
  end
end
