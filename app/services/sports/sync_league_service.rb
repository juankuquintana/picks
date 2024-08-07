# frozen_string_literal: true

module Sports
  # Syncs a league and its country data.
  #
  # @param adapter_key [String] Adapter from which the data will come
  # @param id [Integer] ID of the league
  class SyncLeagueService < Picks::Service

    def initialize(adapter_key, id)
      @adapter_key = adapter_key
      @id = id
    end

    def call
      result = Sports::Adapters.get_current_league(adapter_key, id)
      struct = result.leagues.first

      country = Country.find_by(code: struct.country.code) || Country.find_by(name: struct.country.name) || Country.new
      country.name = struct.country.name
      country.code = struct.country.code
      country.flag = struct.country.flag
      country.save!

      league = LeagueQuery.find_by_adapter_reference(adapter_key, id) || League.new(adapters: {})
      league.name = struct.name
      league.parameterized_name = struct.name.parameterize
      league.logo = struct.logo
      league.adapters[adapter_key] = id
      league.country = country
      league.season_start = struct.season_start
      league.season_end = struct.season_end
      league.save!
    end

    private

    attr_reader :adapter_key, :id

  end
end
