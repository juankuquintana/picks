# frozen_string_literal: true

require 'test_helper'

module Pools
  class CreateInteractorTest < ActiveSupport::TestCase

    describe '#call' do
      before do
        @user = create(:user_with_account)
        @league = create(:league)
        create(:round, league: @league, season: 2024)
      end

      it 'succeeds' do
        result = described_class.result(user: @user, name: 'Quiniela', league_id: @league.id)
        assert result.success?
      end

      describe 'when ActiveRecord::RecordInvalid' do
        before do
          @league = build(:league)
        end

        it 'logs correctly' do
          Picks::Logger.expects(:loge).with('interactors.pools.create_interactor.failed', anything)

          described_class.result(user: @user, name: 'Quiniela', league_id: @league.id)
        end

        it 'notifies the error' do
          Picks::Error.expects(:notify_exception).with(anything)

          described_class.result(user: @user, name: 'Quiniela', league_id: @league.id)
        end

        it 'fails' do
          result = described_class.result(user: @user, name: 'Quiniela', league_id: @league.id)

          assert_not result.success?
        end
      end
    end

  end
end
