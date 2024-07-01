# frozen_string_literal: true

FactoryBot.define do
  factory :activity_log do
    association :user
    association :account
    name { ActivityLog::SESSION_CREATE }
    actor { ActivityLog::SYSTEM_ACTOR }
    identifiers { nil }
    data { nil }
  end
end
