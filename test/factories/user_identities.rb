# frozen_string_literal: true

FactoryBot.define do
  factory :user_identity do
    association :user
    email { Faker::Internet.email }
    name { UserIdentity::NAMES.sample }
  end
end
