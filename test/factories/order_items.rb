# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    association :order
    state { OrderItem::STATE_NEW }
    failure_description { nil }

    trait :with_bank_statement do
      order_item { create(:bank_statement) }
    end
  end
end
