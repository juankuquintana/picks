# frozen_string_literal: true

module ApiSports
  module Actions
    module Football
      module League
        class Leagues < ApiSports::Action

          # Implements https://www.api-football.com/documentation-v3#tag/Leagues/operation/get-leagues
          #
          # @param league [BigDecimal] ID of the league
          # @return [ApiSports::Structs::Football::LeaguesResult] The result of the endpoint.
          def call(league = nil)
            params = { id: league }.compact
            response = execute(METHOD_GET, "/leagues?#{URI.encode_www_form(params)}", {})
            parse_response(response.body)
          end

          private

          def parse_response(body)
            ApiSports::Structs::Football::LeaguesResult.new(
                **extract_defaults(body),
                leagues: Array(body['response']).map do |entry|
                  ApiSports::Structs::League.new(
                      id: entry.dig('league', 'id'),
                      name: entry.dig('league', 'name'),
                      type: entry.dig('league', 'type'),
                      logo: entry.dig('league', 'logo'),
                      country: ApiSports::Structs::Country.new(
                          name: entry.dig('country', 'name'),
                          code: parse_string(entry.dig('country', 'code')),
                          flag: parse_string(entry.dig('country', 'flag'))
                        )
                    )
                end
              )
          end

          def parse_string(value)
            value == 'nil' ? nil : value
          end

        end
      end
    end
  end
end
