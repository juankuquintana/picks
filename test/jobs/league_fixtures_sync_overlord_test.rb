# frozen_string_literal: true

require 'test_helper'

class LeagueFixturesSyncOverlordTest < ActiveSupport::TestCase

  describe '#perform' do
    it 'queues the job' do
      described_class.jobs.clear

      described_class.perform_async

      assert_equal described_class.jobs.size, 1
    end

    it 'queues the LeagueFixturesSyncWorker' do
      LeagueFixturesSyncWorker.jobs.clear
      create(:league)

      described_class.new.perform

      assert_equal LeagueFixturesSyncWorker.jobs.size, 1
    end

    it 'logs the worker' do
      Picks::Logger.expects(:logi).with('jobs.league_fixtures_sync_overlord.started')
      Picks::Logger.expects(:logi).with('jobs.league_fixtures_sync_overlord.completed')

      described_class.new.perform
    end
  end

end
