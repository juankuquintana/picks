# frozen_string_literal: true

require 'test_helper'

class ActivityLogTest < ActiveSupport::TestCase

  it 'validates presence of name and actor' do
    activity_log = ActivityLog.new(name: nil, actor: nil)
    assert_not activity_log.valid?
    assert_includes activity_log.errors.full_messages_for(:name), "Name can't be blank"
    assert_includes activity_log.errors.full_messages_for(:actor), "Actor can't be blank"
  end

  it 'validates associations' do
    user = User.create(email: 'user@example.com')
    account = Account.create(email: 'account@example.com')
    activity_log = ActivityLog.create(name: 'some_name', actor: 'some_actor', user:, account:)

    assert_equal user, activity_log.user
    assert_equal account, activity_log.account
  end

end
