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
          # @return [ApiSports::Structs::Football::FixturesResult] The result of the endpoint.
          def call(league, season)
            params = { league:, season: }
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
                      date: entry.dig('fixture', 'date')
                    )
                end
              )
          end

        end
      end
    end
  end
end
