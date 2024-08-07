# frozen_string_literal: true

FactoryBot.define do
  factory :round do
    association :league
    sequence :name do |n|
      "Jornada #{n}"
    end
    sequence :parameterized_name do |n|
      "Jornada #{n}".parameterize
    end
    order { 1 }
    season { 2024 }
  end
end
