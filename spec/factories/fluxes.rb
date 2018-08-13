FactoryBot.define do
  factory :flux do
    rx { Faker::Number.non_zero_digit }
    tx { Faker::Number.non_zero_digit }
    domain_id nil
  end
end
