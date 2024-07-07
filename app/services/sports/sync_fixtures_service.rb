# frozen_string_literal: true

module Sports
  # Syncs the fixtures of the day data to our local database.
  #
  # @param adapter_key [String]
  class SyncFixturesService < Picks::Service

    def initialize(adapter_key)
      @adapter_key = adapter_key
    end

    def call
      result = Sports::Adapters.get_today_fixtures(adapter_key)
      result.fixtures.each do |struct|
        fixture = FixtureQuery.find_by_adapter_reference(adapter_key, struct.id)
        next unless fixture

        fixture.update!(home_team_score: struct.home_team_score, away_team_score: struct.away_team_score)
      end
    end

    private

    attr_reader :adapter_key

  end
end
