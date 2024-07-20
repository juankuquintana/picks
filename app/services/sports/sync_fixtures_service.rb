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

        fixture.update!(
          home_team_score: struct.home_team_score,
          away_team_score: struct.away_team_score,
          state: state(struct.short_status),
          score: {
            penalties: struct.score['penalty']
          }.compact
        )
      end
    end

    private

    attr_reader :adapter_key

    def state(state)
      case state
      when 'TBD', 'NS'
        Fixture::STATE_NOT_STARTED
      when '1H', 'HT', '2H', 'ET', 'BT', 'P', 'LIVE'
        Fixture::STATE_IN_PROGRESS
      when 'FT', 'AET', 'PEN'
        Fixture::STATE_FINISHED
      when 'PST'
        Fixture::STATE_POSTPONED
      end
    end

  end
end
