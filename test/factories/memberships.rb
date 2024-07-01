# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    association :user
    association :account
    primary { true }
  end
end
