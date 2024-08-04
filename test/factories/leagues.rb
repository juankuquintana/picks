# frozen_string_literal: true

FactoryBot.define do
  factory :league do
    name { Faker::Sports::Football.competition }
    logo { Faker::Company.logo }
    state { League::STATE_ACTIVE }
    season_start { Time.zone.today + 1.year }
    season_end { Time.zone.today + 1.year }
    adapters { { api_sports: Faker::Number.number } }
    association :country
  end
end
