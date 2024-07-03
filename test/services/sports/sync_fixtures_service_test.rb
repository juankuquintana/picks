# frozen_string_literal: true

require 'test_helper'

module Sports
  class SyncFixturesServiceTest < ActiveSupport::TestCase

    describe '#call' do
      before do
        @league = create(:league)
        @round = create(:round, league: @league, name: 'Group A - 1')
        @team1 = create(:team, adapters: { Sports::Adapters::ApiSportsAdapter::KEY => 25 })
        @team2 = create(:team, adapters: { Sports::Adapters::ApiSportsAdapter::KEY => 1108 })
        stub_request(ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o)
            .to_return(read_fixture('api_sports/football/get_fixtures/success_200_single.http'))
      end

      it 'creates a fixture' do
        assert_difference -> { Fixture.count }, 1 do
          described_class.call(Sports::Adapters::ApiSportsAdapter::KEY, @league, 2024)
        end
      end

      describe 'when fixture already exists' do
        before do
          create(:fixture, home_team: @team1, away_team: @team2, round: @round, adapters: { Sports::Adapters::ApiSportsAdapter::KEY => 1_145_509 })
        end

        it 'does not create a fixture' do
          assert_no_difference -> { Fixture.count } do
            described_class.call(Sports::Adapters::ApiSportsAdapter::KEY, @league, 2024)
          end
        end
      end
    end

  end
end
