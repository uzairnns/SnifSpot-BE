FactoryBot.define do
  factory :review do
    association :spot
    body { Faker::Lorem.sentence }
  end
end
