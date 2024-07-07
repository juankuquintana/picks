# frozen_string_literal: true

class FixtureSyncWorker

  include Sidekiq::Job

  def perform
    Picks::Logger.logi('workers.fixture_sync_worker.started')

    Sports::SyncFixturesService.call(Sports::Adapters::ApiSportsAdapter::KEY)

    Picks::Logger.logi('workers.fixture_sync_worker.completed')
  end

end
