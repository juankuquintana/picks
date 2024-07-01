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
      result = Sports::Adapters.get_league_teams(adapter_key, league.adapters[adapter_key], season)
      result.teams.each do |struct|
        team = TeamQuery.find_by_adapter_reference(adapter_key, struct.id) || Team.new
        team.name = struct.name
        team.logo = struct.logo
        team.code = struct.code
        team.adapters = { adapter_key => struct.id }
        team.save!
      end
    end

    private

    attr_reader :adapter_key, :league, :season

  end
end
