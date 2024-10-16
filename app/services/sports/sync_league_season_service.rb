# frozen_string_literal: true

module Sports
  # Syncs a league season teams data to our local database.
  #
  # @param adapter_key [String]
  # @param league [String] the league adapter reference ID
  # @param season [String] Year (YYYY) or season we are getting information from
  class SyncTeamsService < Picks::Service

    def initialize(adapter_key, league, season)
      @adapter_key = adapter_key
      @league = league
      @season = season
    end

    def call
      Sports::SyncLeagueService.call(Sports::Adapters::ApiSportsAdapter::KEY, ApiSports::Extensions::LigaMx::ID)
      Sports::SyncTeamsService.call(Sports::Adapters::ApiSportsAdapter::KEY, league, 2024)
      Sports::SyncRoundsService.call(Sports::Adapters::ApiSportsAdapter::KEY, league, 2024)
    end

    private

    attr_reader :adapter_key, :league, :season

  end
end
