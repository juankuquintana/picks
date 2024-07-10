# frozen_string_literal: true

class LeagueFixturesSyncWorker

  include Sidekiq::Job

  def perform(league_id)
    Picks::Logger.logi('jobs.league_fixtures_sync_worker.started', league_id:)

    league = League.find(league_id)
    Sports::SyncRoundsService.call(Sports::Adapters::ApiSportsAdapter::KEY, league, league.most_recent_season)
    Sports::SyncLeagueFixturesService.call(Sports::Adapters::ApiSportsAdapter::KEY, league, league.most_recent_season)

    Picks::Logger.logi('jobs.league_fixtures_sync_worker.completed', league_id:)
  end

end
