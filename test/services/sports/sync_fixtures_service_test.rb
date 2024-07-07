# frozen_string_literal: true

require 'test_helper'

module Sports
  class SyncFixturesServiceTest < ActiveSupport::TestCase

    describe '#call' do
      before do
        @fixture = create(:fixture, adapters: { Sports::Adapters::ApiSportsAdapter::KEY => 1_158_131 })
        stub_request(ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o)
            .to_return(read_fixture('api_sports/football/get_fixtures/success_200_today.http'))
      end

      it 'updates the fixture' do
        described_class.call(Sports::Adapters::ApiSportsAdapter::KEY)

        @fixture.reload
        assert_equal @fixture.home_team_score, 2
        assert_equal @fixture.away_team_score, 3
      end

      describe 'when fixture does not exists' do
        it 'does not create a fixture' do
          assert_no_difference -> { Fixture.count } do
            described_class.call(Sports::Adapters::ApiSportsAdapter::KEY)
          end
        end
      end
    end

  end
end
