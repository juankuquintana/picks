# frozen_string_literal: true

module ApiSports
  module Actions
    module Football
      module League
        class Seasons < ApiSports::Action

          # Implements https://www.api-football.com/documentation-v3#tag/Leagues/operation/get-seasons
          #
          # @return [ApiSports::Structs::Football::SeasonsResult>] The result of the endpoint.
          def call
            response = execute(METHOD_GET, '/leagues/seasons', {})
            parse_response(response.body)
          end

          private

          def parse_response(body)
            ApiSports::Structs::Football::SeasonsResult.new(
                **extract_defaults(body),
                years: body['response']
              )
          end

        end
      end
    end
  end
end
