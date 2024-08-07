# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Sports::Football.team }
    sequence :parameterized_name do |n|
      "#{Faker::Sports::Football.team} #{n}".parameterize
    end
    logo { Faker::Company.logo }
    adapters { { api_sports: Faker::Number.number } }
  end
end
