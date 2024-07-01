# frozen_string_literal: true

require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  it 'validates email presence' do
    account = Account.new

    assert_not account.valid?, 'Account is valid without an email'

    assert_includes account.errors[:email], "can't be blank"
  end

  it 'validates membership associations' do
    account = Account.create(email: 'test@example.com')
    user1 = User.create(email: 'user1@example.com')
    user2 = User.create(email: 'user2@example.com')
    Membership.create(account:, user: user1)
    Membership.create(account:, user: user2)

    assert_equal [user1, user2], account.users
  end

  it 'validates activity log associations' do
    account = Account.create(email: 'test@example.com')
    activity_log = ActivityLog.create(account:, name: ActivityLog::SESSION_CREATE, actor: ActivityLog::SYSTEM_ACTOR)

    assert_equal [activity_log], account.activity_logs
  end

  it 'does a dependent destroy' do
    account = Account.create(email: 'test@example.com')
    user1 = User.create(email: 'user1@example.com')
    user2 = User.create(email: 'user2@example.com')
    Membership.create(account:, user: user1)
    Membership.create(account:, user: user2)

    account.destroy

    assert_empty Membership.where(account_id: account.id)
  end

  it 'email should be unique' do
    unique_account = Account.new(email: 'unique@example.com')
    assert unique_account.valid?, 'Account with unique email should be valid'

    assert unique_account.save, 'Failed to save account with unique email'

    duplicate_account = Account.new(email: 'unique@example.com')
    assert_not duplicate_account.valid?, 'Account with duplicate email should not be valid'
    assert_includes duplicate_account.errors.messages[:email], 'has already been taken', 'Duplicate email error message not found'
  end

end
