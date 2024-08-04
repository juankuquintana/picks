# frozen_string_literal: true

require 'test_helper'

module ApiSports
  module Actions
    module Football
      module League
        class LeaguesTest < ActiveSupport::TestCase

          before do
            stub_request(ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o)
                .to_return(read_fixture('api_sports/football/get_leagues/success_200.http'))
          end

          describe '#call' do
            it 'makes the correct request' do
              described_class.new.call

              assert_requested ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o, times: 1
            end

            it 'returns a ApiSports::Structs::Football::LeaguesResult' do
              result = described_class.new.call

              assert_kind_of ApiSports::Structs::Football::LeaguesResult, result

              league = result.leagues.first
              assert_kind_of ApiSports::Structs::League, league
              assert_equal league.name, 'Euro Championship'
              assert_equal league.logo, 'https://media.api-sports.io/football/leagues/4.png'
              assert_equal league.season_start, Date.new(2024, 6, 14)
              assert_equal league.season_end, Date.new(2024, 7, 2)

              country = league.country
              assert_kind_of ApiSports::Structs::Country, country
              assert_equal country.name, 'World'
              assert_nil country.flag
              assert_nil country.code
            end
          end

        end
      end
    end
  end
end
