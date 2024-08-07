# frozen_string_literal: true

FactoryBot.define do
  factory :fixture do
    datetime { DateTime.now }
    adapters { { Sports::Adapters::ApiSportsAdapter::KEY => 1 } }
    home_team_score { 0 }
    away_team_score { 0 }
    state { Fixture::STATE_NOT_STARTED }

    association :round, factory: :round
    association :home_team, factory: :team
    association :away_team, factory: :team
  end
end
