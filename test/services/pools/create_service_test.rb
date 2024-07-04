# frozen_string_literal: true

require 'test_helper'

module Pools
  class CreateServiceTest < ActiveSupport::TestCase

    describe '#call' do
      before do
        @league = create(:league)
        create(:round, league: @league)
        @user = create(:user_with_account)
      end

      it 'creates a pool' do
        assert_difference -> { Pool.count }, 1 do
          described_class.call('Liga de Juan', @league.id, @user)
        end
      end

      it 'creates a pool_user' do
        assert_difference -> { PoolUser.count }, 1 do
          described_class.call('Liga de Juan', @league.id, @user)
        end
      end

      it 'records the activity' do
        Picks::Event.expects(:notify).with(ActivityLog::POOL_CREATE, anything, anything, anything)

        described_class.call('Liga de Juan', @league.id, @user)
      end
    end

  end
end
