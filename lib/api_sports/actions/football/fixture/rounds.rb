# frozen_string_literal: true

module ApiSports
  module Actions
    module Football
      module Fixture
        class Rounds < ApiSports::Action

          # Implements https://www.api-football.com/documentation-v3#tag/Fixtures/operation/get-fixtures-rounds
          #
          # @param league [BigDecimal] ID of the league
          # @param season [String] Season of the leage (4 digits) YYYY
          # @param current [Boolean] Wether to bring only the current round
          # @return [ApiSports::Structs::Football::RoundsResult] The result of the endpoint.
          def call(league, season, current: false)
            params = { league:, season:, current: }
            response = execute(METHOD_GET, "/fixtures/rounds?#{URI.encode_www_form(params)}", {})
            parse_response(response.body)
          end

          private

          def parse_response(body)
            ApiSports::Structs::Football::RoundsResult.new(
                **extract_defaults(body),
                rounds: body['response']
              )
          end

        end
      end
    end
  end
end
