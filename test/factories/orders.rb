# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    association :account
    association :user
    state { Order::STATE_NEW }
    runs { 0 }
  end
end
