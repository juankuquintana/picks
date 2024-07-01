# frozen_string_literal: true

require 'test_helper'

module Sports
  class SyncRoundsServiceTest < ActiveSupport::TestCase

    describe '#call' do
      before do
        @league = create(:league, adapters: { Sports::Adapters::ApiSportsAdapter::KEY => 4 })
        stub_request(ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o)
            .to_return(read_fixture('api_sports/football/get_rounds/success_200.http'))
      end

      it 'creates a round' do
        assert_difference -> { Round.count }, 19 do
          described_class.call(Sports::Adapters::ApiSportsAdapter::KEY, @league, 2024)
        end
      end

      describe 'when round already exists' do
        before do
          create(:round, season: 2024, league_id: @league.id, name: 'Group A - 1')
        end

        it 'does not create a round' do
          assert_difference -> { Round.count }, 18 do
            described_class.call(Sports::Adapters::ApiSportsAdapter::KEY, @league, 2024)
          end
        end
      end
    end

  end
end
