# frozen_string_literal: true

FactoryBot.define do
  factory :pool_user do
    association :pool
    association :user
    role { PoolUser::ROLE_ADMIN }
  end
end
