# frozen_string_literal: true

require 'test_helper'

module ApiSports
  module Actions
    module Football
      module Team
        class TeamsTest < ActiveSupport::TestCase

          before do
            stub_request(ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o)
                .to_return(read_fixture('api_sports/football/get_teams/success_200.http'))
          end

          describe '#call' do
            it 'makes the correct request' do
              described_class.new.call(4, 2024)

              assert_requested ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o, times: 1
            end

            it 'returns a ApiSports::Structs::Football::TeamsResult' do
              result = described_class.new.call(4, 2024)

              assert_kind_of ApiSports::Structs::Football::TeamsResult, result

              team = result.teams.first
              assert_kind_of ApiSports::Structs::Team, team
              assert_equal team.id, 1
              assert_equal team.name, 'Belgium'
              assert_equal team.code, 'BEL'
              assert_equal team.logo, 'https://media.api-sports.io/football/teams/1.png'
            end
          end

        end
      end
    end
  end
end
