# frozen_string_literal: true

require 'test_helper'

module Bets
  class InsertServiceTest < ActiveSupport::TestCase

    describe '#call' do
      describe 'when is valid' do
        before do
          @league = create(:league)
          @round = create(:round, league: @league)
          @fixture = create(:fixture, round: @round, datetime: DateTime.now + 5.minutes)
          @user = create(:user_with_account)
          @pool = create(:pool, league: @league)
          create(:pool_user, pool: @pool, user: @user)
        end

        it 'creates a bet' do
          assert_difference -> { Bet.count }, 1 do
            described_class.call(@user, @pool.id, @fixture.id, 2, 3)
          end
        end

        it 'records the activity' do
          Picks::Event.expects(:notify).with(ActivityLog::BET_INSERT, anything, anything, anything, anything, anything)

          described_class.call(@user, @pool.id, @fixture.id, 2, 3)
        end

        describe 'when fixture is not associated to league' do
          it 'raises ActiveRecord::RecordNotFound' do
            fixture = create(:fixture, datetime: DateTime.now + 5.minutes)

            assert_raises(ActiveRecord::RecordNotFound) do
              described_class.call(@user, @pool.id, fixture.id, 2, 3)
            end
          end
        end

        describe 'when fixture has already started' do
          it 'raises ActiveRecord::RecordNotFound' do
            fixture = create(:fixture, round: @round, state: Fixture::STATE_IN_PROGRESS)

            assert_raises(StandardError) do
              described_class.call(@user, pool.id, fixture.id, 2, 3)
            end
          end
        end

        describe 'when user has no access to pool' do
          it 'raises ActiveRecord::RecordNotFound' do
            pool = create(:pool)

            assert_raises(ActiveRecord::RecordNotFound) do
              described_class.call(@user, pool.id, @fixture.id, 2, 3)
            end
          end
        end
      end
    end

  end
end
