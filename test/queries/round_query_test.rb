# frozen_string_literal: true

require 'test_helper'

class RoundQueryTest < ActiveSupport::TestCase

  describe '#find_first_round_from_round' do
    it 'succeeds' do
      league = create(:league)
      create(:round, league:, season: 2023, order: 1, name: 'Jornada 1')
      create(:round, league:, season: 2023, order: 2, name: 'Jornada 2')
      create(:round, league:, season: 2024, order: 1, name: 'Jornada 1')
      round = create(:round, league:, season: 2024, order: 2, name: 'Jornada 2')

      found_round = described_class.find_first_round_from_round(round)
      assert_equal found_round.season, '2024'
      assert_equal found_round.order, 1
      assert_equal found_round.name, 'Jornada 1'
    end

    describe 'when round has a group' do
      it 'succeeds' do
        league = create(:league)
        create(:round, league:, season: 2023, order: 1, name: 'Jornada 1')
        create(:round, league:, season: 2023, order: 2, name: 'Jornada 2')
        create(:round, league:, season: 2024, order: 1, group: 1, name: 'Jornada 1')
        create(:round, league:, season: 2024, order: 2, group: 1, name: 'Jornada 2')
        create(:round, league:, season: 2024, order: 1, group: 2, name: 'Jornada 3')
        round = create(:round, league:, season: 2024, order: 2, group: 2, name: 'Jornada 4')

        found_round = described_class.find_first_round_from_round(round)
        assert_equal found_round.season, '2024'
        assert_equal found_round.order, 1
        assert_equal found_round.name, 'Jornada 3'
        assert_equal found_round.group, 2
      end
    end
  end

end
