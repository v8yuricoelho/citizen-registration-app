# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    zip_code { Faker::Address.zip_code }
    street { Faker::Address.street_address }
    unit { Faker::Address.secondary_address }
    neighborhood { Faker::Address.community }
    city { Faker::Address.city }
    ibge_code { Faker::Number.number(digits: 7) }
    uf { Address.ufs.values.sample }
  end
end
