# frozen_string_literal: true

FactoryBot.define do
  factory :pool do
    association :league
    association :round
    name { 'Quiniela futbolera' }
    code { SecureRandom.hex(10) }
  end
end
