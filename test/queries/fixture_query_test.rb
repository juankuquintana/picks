# frozen_string_literal: true

require 'test_helper'

class FixtureQueryTest < ActiveSupport::TestCase

  describe '#find_by_adapter_reference' do
    it 'succeeds' do
      fixture = create(:fixture, adapters: { Sports::Adapters::ApiSportsAdapter::KEY => 1 })
      found_fixture = described_class.find_by_adapter_reference(Sports::Adapters::ApiSportsAdapter::KEY, 1)
      assert_equal fixture, found_fixture, 'fixture not found by adapter reference'
    end
  end

  describe '#league_nearest_fixture' do
    before do
      @round = create(:round)
    end

    it 'succeeds' do
      create(:fixture, datetime: DateTime.now + 2.minutes)
      create(:fixture, round: @round, datetime: DateTime.now + 5.minutes)
      create(:fixture, round: @round, datetime: DateTime.now - 5.minutes)
      fixture = create(:fixture, round: @round, datetime: DateTime.now + 3.minutes)

      found_fixture = described_class.league_nearest_fixture(@round.league.id)
      assert_equal fixture, found_fixture, 'fixture not found'
    end
  end

  describe '#by_round' do
    before do
      @round = create(:round)
    end

    it 'succeeds' do
      create(:fixture, datetime: DateTime.now + 2.minutes)
      fixture3 = create(:fixture, round: @round, datetime: DateTime.now + 5.minutes)
      fixture1 = create(:fixture, round: @round, datetime: DateTime.now - 5.minutes)
      fixture2 = create(:fixture, round: @round, datetime: DateTime.now + 3.minutes)

      fixtures = described_class.by_round(@round)
      assert_equal fixtures, [fixture1, fixture2, fixture3]
    end
  end

end
