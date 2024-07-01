# frozen_string_literal: true

require 'test_helper'

module ApiSports
  module Actions
    module Football
      module Fixture
        class RoundsTest < ActiveSupport::TestCase

          before do
            stub_request(ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o)
                .to_return(read_fixture('api_sports/football/get_rounds/success_200.http'))
          end

          describe '#call' do
            it 'makes the correct request' do
              described_class.new.call(1, 2024)

              assert_requested ApiSports::Action::METHOD_GET, /#{ApiSports::Client::DEFAULT_BASE_URL}/o, times: 1
            end

            it 'returns a ApiSports::Structs::Football::RoundsResult' do
              result = described_class.new.call(1, 2024)

              assert_kind_of ApiSports::Structs::Football::RoundsResult, result
              assert_equal result.rounds.length, 19
              assert_equal 'Group A - 1', result.rounds.first
            end
          end

        end
      end
    end
  end
end
