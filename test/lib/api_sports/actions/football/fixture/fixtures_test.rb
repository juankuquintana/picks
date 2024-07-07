# frozen_string_literal: true

require 'test_helper'

module ApiSports
  module Actions
    module Football
      module Fixture
        class FixturesTest < ActiveSupport::TestCase

          before do
            stub_request(ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o)
                .to_return(read_fixture('api_sports/football/get_fixtures/success_200.http'))
          end

          describe '#call' do
            it 'makes the correct request' do
              described_class.new.call(1, 2024, nil)

              assert_requested ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o, times: 1
            end

            it 'returns a ApiSports::Structs::Football::FixturesResult' do
              result = described_class.new.call(1, 2024, nil)

              assert_kind_of ApiSports::Structs::Football::FixturesResult, result
              assert_equal result.fixtures.length, 46

              fixture = result.fixtures.first
              assert_kind_of ApiSports::Structs::Football::Fixture, fixture
              assert_equal fixture.id, 1_145_509
              assert_equal fixture.date, DateTime.iso8601('2024-06-14T19:00:00+00:00')
              assert_equal fixture.home_team_id, 25
              assert_equal fixture.home_team_score, 5
              assert_equal fixture.away_team_id, 1108
              assert_equal fixture.away_team_score, 1
            end
          end

        end
      end
    end
  end
end
