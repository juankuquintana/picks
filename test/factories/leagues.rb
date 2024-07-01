# frozen_string_literal: true

FactoryBot.define do
  factory :league do
    name { Faker::Sports::Football.competition }
    logo { Faker::Company.logo }
    adapters { { api_sports: Faker::Number.number } }
    association :country
  end
end
