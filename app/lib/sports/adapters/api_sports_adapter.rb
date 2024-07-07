# frozen_string_literal: true

module Sports
  module Adapters
    class ApiSportsAdapter

      KEY = 'api_sports'

      class << self

        def get_league(id)
          ApiSports::Actions::Football::League::Leagues.new.call(id)
        end

        def get_league_rounds(league_id, season)
          ApiSports::Actions::Football::Fixture::Rounds.new.call(league_id, season)
        end

        def get_league_current_round(league_id, season)
          result = ApiSports::Actions::Football::Fixture::Rounds.new.call(league_id, season, current: true)
          result.rounds.first
        end

        def get_league_teams(league_id, season)
          ApiSports::Actions::Football::Team::Teams.new.call(league_id, season)
        end

        def get_league_fixtures(league_id, season)
          ApiSports::Actions::Football::Fixture::Fixtures.new.call(league_id, season, nil)
        end

        def get_today_fixtures
          ApiSports::Actions::Football::Fixture::Fixtures.new.call(nil, nil, Time.zone.today)
        end

      end

    end
  end
end
