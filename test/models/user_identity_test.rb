# frozen_string_literal: true

require 'test_helper'

class UserIdentityTest < ActiveSupport::TestCase

  it 'validates associations' do
    user = User.create(email: 'user@example.com')

    user_identity = UserIdentity.create(user:, email: 'identity@example.com', name: 'google')

    assert_equal user, user_identity.user
  end

  it 'validates presence' do
    user_identity = UserIdentity.new

    assert_not user_identity.valid?, 'UserIdentity is valid without email and name'

    assert_includes user_identity.errors[:email], "can't be blank"
    assert_includes user_identity.errors[:name], "can't be blank"
  end

  it 'validates names enum' do
    assert_raises(ArgumentError) do
      UserIdentity.create(email: 'identity@example.com', name: 'invalid_name')
    end

    user_identity = UserIdentity.create(email: 'identity@example.com', name: UserIdentity.names[:google])

    assert_equal UserIdentity.names[:google], user_identity.name
  end

end
