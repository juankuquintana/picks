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

  describe '#ongoing' do
    it 'succeeds' do
      league = create(:league, season_start: Time.zone.today - 5.days, season_end: Time.zone.today + 5.days)
      assert league.ongoing

      league.season_start = Time.zone.today + 1.day
      assert_equal league.ongoing, false
    end
  end

  describe 'scopes' do
    describe '#ongoing' do
      before do
        @league = create(:league, season_start: Time.zone.today - 5.days, season_end: Time.zone.today + 5.days)
        @league2 = create(:league, season_start: Time.zone.today, season_end: Time.zone.today + 5.days)
        create(:league, season_start: Time.zone.today - 6.days, season_end: Time.zone.today - 5.days)
        create(:league, season_start: Time.zone.today + 1.day, season_end: Time.zone.today + 5.days)
      end

      it 'succeeds' do
        leagues = League.ongoing
        assert_equal leagues.to_a, [@league, @league2]
      end
    end

    describe '#active' do
      before do
        @league = create(:league, state: League::STATE_ACTIVE)
        create(:league, state: League::STATE_INACTIVE)
      end

      it 'succeeds' do
        leagues = League.active
        assert_equal leagues.to_a, [@league]
      end
    end
  end

end
