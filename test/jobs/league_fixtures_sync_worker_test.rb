# frozen_string_literal: true

require 'test_helper'

class LeagueFixturesSyncWorkerTest < ActiveSupport::TestCase

  describe '#perform' do
    before do
      @league = create(:league)
      @round = create(:round, league: @league)
    end

    it 'queues the job' do
      described_class.jobs.clear

      described_class.perform_async(@league.id)

      assert_equal described_class.jobs.size, 1
    end

    it 'delegates to Sports::SyncRoundsService' do
      Sports::SyncRoundsService.expects(:call).with(Sports::Adapters::ApiSportsAdapter::KEY, @league, @round.season)
      Sports::SyncLeagueFixturesService.expects(:call).with(Sports::Adapters::ApiSportsAdapter::KEY, @league, @round.season)

      described_class.new.perform(@league.id)
    end

    it 'logs the worker' do
      Sports::SyncRoundsService.stubs(:call)
      Sports::SyncLeagueFixturesService.stubs(:call)

      Picks::Logger.expects(:logi).with('jobs.league_fixtures_sync_worker.started', league_id: @league.id)
      Picks::Logger.expects(:logi).with('jobs.league_fixtures_sync_worker.completed', league_id: @league.id)

      described_class.new.perform(@league.id)
    end
  end

end
