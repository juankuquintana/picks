# frozen_string_literal: true

module ApiSports
  module Actions
    module Football
      module Fixture
        class Fixtures < ApiSports::Action

          # Implements https://www.api-football.com/documentation-v3#tag/Fixtures/operation/get-fixtures
          #
          # @param league [BigDecimal] ID of the league
          # @param season [String] Season of the leage (4 digits) YYYY
          # @param date [Date] Date of the fixtures to return
          # @return [ApiSports::Structs::Football::FixturesResult] The result of the endpoint.
          def call(league = nil, season = nil, date = nil)
            params = { league:, season:, date: date&.strftime('%Y-%m-%d') }.compact
            response = execute(METHOD_GET, "/fixtures?#{URI.encode_www_form(params)}", {})
            parse_response(response.body)
          end

          private

          def parse_response(body)
            ApiSports::Structs::Football::FixturesResult.new(
                **extract_defaults(body),
                fixtures: Array(body['response']).map do |entry|
                  ApiSports::Structs::Football::Fixture.new(
                      id: entry.dig('fixture', 'id'),
                      date: parse_date_time(entry.dig('fixture', 'date')),
                      short_status: entry.dig('fixture', 'status', 'short'),
                      score: entry.dig('score'),
                      home_team_id: entry.dig('teams', 'home', 'id'),
                      away_team_id: entry.dig('teams', 'away', 'id'),
                      home_team_score: entry.dig('goals', 'home'),
                      away_team_score: entry.dig('goals', 'away'),
                      round: entry.dig('league', 'round')
                    )
                end
              )
          end

        end
      end
    end
  end
end
