# frozen_string_literal: true

require 'test_helper'

class LeagueTest < ActiveSupport::TestCase

  context 'associations' do
    should have_many(:pools)
    should have_many(:rounds)
  end

  context 'validations' do
    subject { build(:league) }

    should validate_presence_of(:name)
    should validate_presence_of(:logo)
    should validate_presence_of(:adapters)
  end

  describe '#most_recent_season' do
    before do
      @league = create(:league)
      create(:round, league: @league, season: 2024)
      create(:round, league: @league, season: 2023)
      create(:round, league: @league, season: 2022)
    end

    it 'finds the most recent season' do
      assert_equal '2024', @league.most_recent_season
    end
  end

end
