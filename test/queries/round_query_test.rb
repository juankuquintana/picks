# frozen_string_literal: true

require 'test_helper'

class RoundQueryTest < ActiveSupport::TestCase

  describe '#find_first_round_of_last_season' do
    it 'succeeds' do
      league = create(:league)
      create(:round, league:, season: 2023, order: 1, name: 'Jornada 1')
      create(:round, league:, season: 2023, order: 2, name: 'Jornada 2')
      create(:round, league:, season: 2024, order: 1, name: 'Jornada 1')
      create(:round, league:, season: 2024, order: 2, name: 'Jornada 2')

      round = described_class.find_first_round_of_last_season(league.id)
      assert_equal round.season, '2024'
      assert_equal round.order, 1
      assert_equal round.name, 'Jornada 1'
    end
  end

end
