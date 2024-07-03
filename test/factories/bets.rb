# frozen_string_literal: true

FactoryBot.define do
  factory :bet do
    association :fixture
    association :pool
    association :user
    home_team_score { 2 }
    away_team_score { 1 }
  end
end
