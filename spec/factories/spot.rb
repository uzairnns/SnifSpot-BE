FactoryBot.define do
  factory :spot do
    title { Faker::Book.title }
    description {Faker::Lorem.paragraph}
    price {Faker::Commerce.price(range: 0..100.0, as_string: true)}
  end
end
