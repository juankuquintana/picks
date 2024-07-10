# frozen_string_literal: true

class FixtureSyncWorker

  include Sidekiq::Job

  def perform
    Picks::Logger.logi('jobs.fixture_sync_worker.started')

    Sports::SyncFixturesService.call(Sports::Adapters::ApiSportsAdapter::KEY)

    Picks::Logger.logi('jobs.fixture_sync_worker.completed')
  end

end
