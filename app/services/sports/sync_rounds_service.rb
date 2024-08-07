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
      result.rounds.map.with_index do |round_name, index|
        round = Round.find_by(league_id: league.id, season:, name: round_name) || Round.new
        round.name = round_name
        round.parameterized_name = round_name.parameterize
        round.league = league
        round.season = season
        round.order = index + 1

        if league.adapters[adapter_key] == ApiSports::Extensions::LigaMx::ID
          if round_name.start_with?(ApiSports::Extensions::LigaMx::SEASON_APERTURA)
            round.group = 1
          elsif round_name.start_with?(ApiSports::Extensions::LigaMx::SEASON_CLAUSURA)
            round.group = 2
          else
            raise StandardError, "Unsupported round name: #{round_name} for league: #{league.adapters[adapter_key]}"
          end
        end

        round.save!
        round
      end
    end

    private

    attr_reader :adapter_key, :league, :season

  end
end
