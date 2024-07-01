# frozen_string_literal: true

FactoryBot.define do
  factory :item_event do
    actor { 'system' }
    event_type { 'event type' }
    data { nil }
  end
end
