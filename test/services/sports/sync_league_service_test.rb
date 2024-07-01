# frozen_string_literal: true

require 'test_helper'

module Sports
  class SyncLeagueServiceTest < ActiveSupport::TestCase

    describe '#call' do
      before do
        stub_request(ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o)
            .to_return(read_fixture('api_sports/football/get_league/success_200.http'))
      end

      it 'creates a league' do
        assert_difference -> { League.count } do
          described_class.call(Sports::Adapters::ApiSportsAdapter::KEY, 1)
        end
      end

      it 'creates a country' do
        assert_difference -> { Country.count } do
          described_class.call(Sports::Adapters::ApiSportsAdapter::KEY, 1)
        end
      end

      describe 'when country already exists' do
        before do
          create(:country, name: 'World')
        end

        it 'does not create a country' do
          assert_no_difference -> { Country.count } do
            described_class.call(Sports::Adapters::ApiSportsAdapter::KEY, 1)
          end
        end
      end

      describe 'when league already exists' do
        before do
          create(:league, adapters: { Sports::Adapters::ApiSportsAdapter::KEY => 1 })
        end

        it 'does not create a league' do
          assert_no_difference -> { League.count } do
            described_class.call(Sports::Adapters::ApiSportsAdapter::KEY, 1)
          end
        end
      end
    end

  end
end
