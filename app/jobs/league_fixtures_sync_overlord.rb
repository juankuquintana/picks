# frozen_string_literal: true

class LeagueFixturesSyncOverlord

  include Sidekiq::Job

  def perform
    Picks::Logger.logi('jobs.league_fixtures_sync_overlord.started')

    League.active.each do |league|
      LeagueFixturesSyncWorker.perform_async(league.id)
    end

    Picks::Logger.logi('jobs.league_fixtures_sync_overlord.completed')
  end

end
