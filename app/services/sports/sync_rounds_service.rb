# frozen_string_literal: true

module Sports
  # Syncs a league season rounds data to our local database.
  #
  # @param adapter_key [String]
  # @param league [String] the league adapter reference ID
  # @param season [String] Year (YYYY) or season we are getting information from
  class SyncRoundsService < Picks::Service

    def initialize(adapter_key, league, season)
      @adapter_key = adapter_key
      @league = league
      @season = season
    end

    def call
      result = Sports::Adapters.get_league_rounds(adapter_key, league.adapters[adapter_key], season)
      result.rounds.each_with_index do |round_name, index|
        round = Round.find_by(league_id: league.id, season:, name: round_name) || Round.new
        round.name = round_name
        round.league = league
        round.season = season
        round.order = index + 1
        round.save!
      end
    end

    private

    attr_reader :adapter_key, :league, :season

  end
end
