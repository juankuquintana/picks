# frozen_string_literal: true

require 'test_helper'

class FeatureFlagQueryTest < ActiveSupport::TestCase

  describe '#enabled?' do
    it 'returns false if a feature is disabled' do
      Flipper.disable :test_feature
      assert_equal(false, described_class.enabled?(:test_feature))
    end

    it 'returns true if a feature is enabled' do
      Flipper.enable :test_feature
      assert_equal(true, described_class.enabled?(:test_feature))
    end
  end

  describe '#enabled_for_user?' do
    it 'returns false if a feature is disabled' do
      user = create(:user)
      Flipper.disable :test_feature
      assert_equal(false, described_class.enabled_for_user?(:test_feature, user))
    end

    it 'returns true if a feature is enabled' do
      user = create(:admin_with_account)
      Flipper.enable_group(:test_feature, :admins)
      assert_equal(true, described_class.enabled_for_user?(:test_feature, user))
    end
  end

end
