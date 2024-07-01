# frozen_string_literal: true

require 'test_helper'

class MembershipTest < ActiveSupport::TestCase

  def setup
    @user = User.create(email: 'user@example.com')
    @account = Account.create(email: 'account@example.com')
  end

  it 'validates associations' do
    membership = Membership.create(user: @user, account: @account)

    assert_equal @user, membership.user
    assert_equal @account, membership.account
  end

  it 'should not save membership with duplicate user_id and account_id' do
    Membership.create!(user_id: @user.id, account_id: @account.id)

    duplicate_membership = Membership.new(user_id: @user.id, account_id: @account.id)

    assert_not duplicate_membership.save, 'Saved duplicate membership'
  end

  it 'should save membership with unique user_id and account_id' do
    unique_membership = Membership.new(user_id: @user.id, account_id: @account.id)

    assert unique_membership.save, 'Failed to save unique membership'
  end

end
