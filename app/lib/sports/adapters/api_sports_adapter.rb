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

      end

    end
  end
end
