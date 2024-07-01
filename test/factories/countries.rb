# frozen_string_literal: true

FactoryBot.define do
  factory :country do
    name { Faker::Address.country }
    flag { Faker::Company.logo }
    code { Faker::Address.country_code }
  end
end
