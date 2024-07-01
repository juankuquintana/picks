# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    passwordless { true }
    admin_at { nil }
    last_login_at { nil }

    factory :user_with_account do
      after(:create) do |user|
        account = create(:account, email: user.email)
        create(:membership, user:, account:)
        create(:user_identity, user:, email: user.email, name: UserIdentity.names[:google])
      end
    end

    factory :admin_with_account do
      after(:create) do |user|
        user.update!(admin_at: Time.current)

        account = create(:account, email: user.email)
        create(:membership, user:, account:)
        create(:user_identity, user:, email: user.email, name: UserIdentity.names[:google])
      end
    end
  end
end
