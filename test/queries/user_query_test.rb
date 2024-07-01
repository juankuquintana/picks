# frozen_string_literal: true

require 'test_helper'

class UserQueryTest < ActiveSupport::TestCase

  describe '#find' do
    it 'finds user by ID' do
      user = create(:user)
      found_user = described_class.find(user.id)
      assert_equal user, found_user, 'User not found by ID'
    end

    it 'finds user by email' do
      user = create(:user)
      found_user = described_class.find(user.email)
      assert_equal user, found_user, 'User not found by email'
    end

    it 'returns nil when user not found' do
      found_user = described_class.find('nonexistent_email@example.com')
      assert_nil found_user, 'User should not be found'
    end
  end

end
