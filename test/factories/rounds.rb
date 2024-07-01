# frozen_string_literal: true

FactoryBot.define do
  factory :round do
    association :league
    name { 'Jornada 1' }
    season { 2024 }
  end
end
