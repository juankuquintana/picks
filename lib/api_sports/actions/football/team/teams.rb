# frozen_string_literal: true

module ApiSports
  module Actions
    module Football
      module Team
        class Teams < ApiSports::Action

          # Implements https://www.api-football.com/documentation-v3#tag/Teams/operation/get-teams
          #
          # @param league [BigDecimal] ID of the league
          # @param season [BigDecimal] Season (YYYY)
          # @return [ApiSports::Structs::Football::TeamsResult] The result of the endpoint.
          def call(league, season)
            params = { league:, season: }.compact
            response = execute(METHOD_GET, "/teams?#{URI.encode_www_form(params)}", {})
            parse_response(response.body)
          end

          private

          def parse_response(body)
            ApiSports::Structs::Football::TeamsResult.new(
                **extract_defaults(body),
                teams: Array(body['response']).map do |entry|
                  ApiSports::Structs::Team.new(
                      id: entry.dig('team', 'id'),
                      name: entry.dig('team', 'name'),
                      code: entry.dig('team', 'code'),
                      logo: entry.dig('team', 'logo')
                    )
                end
              )
          end

        end
      end
    end
  end
end
