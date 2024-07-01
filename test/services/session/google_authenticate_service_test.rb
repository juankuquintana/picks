# frozen_string_literal: true

require 'test_helper'

module Session
  class GoogleAuthenticateServiceTest < ActiveSupport::TestCase

    describe '#call' do
      before do
        Session::CreateService.any_instance.stubs(:call)
      end

      it 'delegates to Session::CreateService' do
        Session::CreateService.expects(:call).with(anything, nil)

        described_class.call('admin@google.com', 'Elon Musk', nil)
      end

      describe 'when user exists' do
        it 'does not change user count' do
          user = create(:user)

          assert_no_difference -> { User.count } do
            described_class.call(user.email, 'random name', nil)
          end
        end

        it 'updates last_login_at' do
          user = create(:user, last_login_at: nil)

          described_class.call(user.email, 'random name', nil)

          assert_not_nil user.reload.last_login_at
        end
      end

      describe 'when user is new' do
        it 'succeeds' do
          email = Faker::Internet.email
          name = 'random name'

          described_class.call(email, name, nil)

          user = User.find_by(email:)
          assert user.passwordless
          assert_nil user.last_login_at

          account = Account.last
          assert_equal account.email, user.email
          assert_equal account.name, name

          membership = Membership.last
          assert membership.primary
          assert_equal membership.user, user
          assert_equal membership.account, account

          user_identity = UserIdentity.last
          assert_equal user_identity.user, user
          assert_equal user_identity.email, user.email
          assert_equal user_identity.name, UserIdentity.names[:google]
        end

        it 'changes user count' do
          user = build(:user)

          assert_difference -> { User.count } do
            described_class.call(user.email, 'random name', nil)
          end
        end

        it 'changes account count' do
          user = build(:user)

          assert_difference -> { Account.count } do
            described_class.call(user.email, 'random name', nil)
          end
        end

        it 'changes membership count' do
          user = build(:user)

          assert_difference -> { Membership.count } do
            described_class.call(user.email, 'random name', nil)
          end
        end

        it 'changes user identity count' do
          user = build(:user)

          assert_difference -> { UserIdentity.count } do
            described_class.call(user.email, 'random name', nil)
          end
        end

        it 'records the activity' do
          user = build(:user)

          Picks::Event.expects(:notify).with(ActivityLog::USER_CREATE, anything, anything, anything, anything)

          described_class.call(user.email, 'random name', nil)
        end
      end
    end

  end
end
