FactoryBot.define do
  factory :domain do
    source_host { Faker::Internet.domain_name }
    dest_host { Faker::Internet.domain_name }
    renewal_date { Faker::Date.backward(14) }
  end
end
