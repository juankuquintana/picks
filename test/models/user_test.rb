# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  it 'validates membership associations' do
    user = User.create(email: 'user@example.com')

    account = Account.create(email: 'account@example.com')
    Membership.create(user:, account:)

    assert_equal [account], user.accounts
  end

  it 'validates activity log associations' do
    user = User.create(email: 'user@example.com')
    activity_log = ActivityLog.create(user:, name: ActivityLog::SESSION_CREATE, actor: ActivityLog::SYSTEM_ACTOR)

    assert_equal [activity_log], user.activity_logs
  end

  it 'validates user_identities associations' do
    user = User.create(email: 'user@example.com')
    user_identity = UserIdentity.create(user:, email: user.email, name: UserIdentity::NAMES.sample)

    assert_equal [user_identity], user.user_identities
  end

  describe '#primary_account' do
    it 'returns the primary account' do
      user = User.create(email: 'user@example.com')

      account1 = Account.create(email: 'account1@example.com')
      account2 = Account.create(email: 'account2@example.com')
      Membership.create(user:, account: account1, primary: true)
      Membership.create(user:, account: account2)

      assert_equal account1, user.primary_account
    end
  end

  it 'creates a session token' do
    user = User.create(email: 'user@example.com')

    assert_not_nil user.session_token
  end

  it 'validates presence' do
    user = User.new

    assert_not user.valid?, 'User is valid without email'

    assert_includes user.errors[:email], "can't be blank"
  end

  it 'email should be unique' do
    unique_user = User.new(email: 'unique@example.com')
    assert unique_user.valid?, 'User with unique email should be valid'

    assert unique_user.save, 'Failed to save user with unique email'

    duplicate_user = User.new(email: 'unique@example.com')
    assert_not duplicate_user.valid?, 'User with duplicate email should not be valid'
    assert_includes duplicate_user.errors.messages[:email], 'has already been taken', 'Duplicate email error message not found'
  end

end
