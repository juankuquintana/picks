# frozen_string_literal: true

require 'test_helper'

module Sports
  class SyncTeamsServiceTest < ActiveSupport::TestCase

    describe '#call' do
      before do
        @league = create(:league)
        stub_request(ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o)
            .to_return(read_fixture('api_sports/football/get_teams/success_200.http'))
      end

      it 'creates a team' do
        assert_difference -> { Team.count }, 24 do
          described_class.call(Sports::Adapters::ApiSportsAdapter::KEY, @league, 2024)
        end
      end

      describe 'when team already exists' do
        before do
          create(:team, name: 'Belgium', adapters: { Sports::Adapters::ApiSportsAdapter::KEY => 1 })
        end

        it 'does not create a country' do
          assert_difference -> { Team.count }, 23 do
            described_class.call(Sports::Adapters::ApiSportsAdapter::KEY, @league, 2024)
          end
        end
      end
    end

  end
end
