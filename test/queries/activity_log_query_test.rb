# frozen_string_literal: true

require 'test_helper'

class ActivityLogQueryTest < ActiveSupport::TestCase

  describe '#user_activities_list' do
    before do
      @user = create(:user)
    end

    it 'returns activity logs from user' do
      create_list(:activity_log, 3, user: @user)
      create_list(:activity_log, 2)

      activity_logs = described_class.user_activities_list(@user)

      activity_logs.each { |activity_log| assert_equal activity_log.user, @user }
    end

    it 'returns activity logs ordered by creation date' do
      create_list(:activity_log, 3, user: @user)

      activity_logs = described_class.user_activities_list(@user)

      assert_equal activity_logs.map(&:created_at), activity_logs.map(&:created_at).sort.reverse
    end
  end

  describe '#account_activities_list' do
    before do
      @account = create(:account)
    end

    it 'returns activity logs from account' do
      create_list(:activity_log, 3, account: @account)
      create_list(:activity_log, 2)

      activity_logs = described_class.account_activities_list(@account)

      activity_logs.each { |activity_log| assert_equal activity_log.account, @account }
    end

    it 'returns activity logs ordered by creation date' do
      create_list(:activity_log, 3, account: @account)

      activity_logs = described_class.account_activities_list(@account)

      assert_equal activity_logs.map(&:created_at), activity_logs.map(&:created_at).sort.reverse
    end
  end

end
