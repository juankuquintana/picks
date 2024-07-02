# frozen_string_literal: true

module Sports
  # Syncs a league season fixtures data to our local database.
  #
  # @param adapter_key [String]
  # @param league [String] the league adapter reference ID
  # @param season [String] Year (YYYY) or season we are getting information from
  class SyncFixturesService < Picks::Service

    def initialize(adapter_key, league, season)
      @adapter_key = adapter_key
      @league = league
      @season = season
    end

    def call
      result = Sports::Adapters.get_league_fixtures(adapter_key, league.adapters[adapter_key], season)
      result.fixtures.each do |struct|
        fixture = FixtureQuery.find_by_adapter_reference(adapter_key, struct.id) || Fixture.new
        fixture.datetime = struct.date
        fixture.home_team = TeamQuery.find_by_adapter_reference(adapter_key, struct.home_team_id)
        fixture.away_team = TeamQuery.find_by_adapter_reference(adapter_key, struct.away_team_id)
        fixture.home_team_score = struct.home_team_score
        fixture.away_team_score = struct.away_team_score
        fixture.round = Round.find_by!(season:, league:, name: struct.round)
        fixture.adapters = { adapter_key => struct.id }
        fixture.save!
      end
    end

    private

    attr_reader :adapter_key, :league, :season

  end
end
