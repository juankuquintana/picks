# frozen_string_literal: true

require 'test_helper'

class FixtureSyncWorkerTest < ActiveSupport::TestCase

  describe '#perform' do
    it 'queues the job' do
      described_class.jobs.clear

      described_class.perform_async

      assert_equal described_class.jobs.size, 1
    end

    it 'delegates to Sports::SyncFixturesService' do
      Sports::SyncFixturesService.expects(:call).with(Sports::Adapters::ApiSportsAdapter::KEY)

      described_class.new.perform
    end

    it 'logs the worker' do
      Sports::SyncFixturesService.stubs(:call)

      Picks::Logger.expects(:logi).with('workers.fixture_sync_worker.started')
      Picks::Logger.expects(:logi).with('workers.fixture_sync_worker.completed')

      described_class.new.perform
    end
  end

end
