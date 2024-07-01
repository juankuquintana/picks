# frozen_string_literal: true

require 'test_helper'

class RoundTest < ActiveSupport::TestCase

  it 'validates league presence' do
    round = Round.new
    assert_not round.valid?, 'Round is valid without a league'
    assert_includes round.errors[:league], 'must exist'
  end

  it 'validates season presence' do
    round = Round.new
    assert_not round.valid?, 'Round is valid without a season'
    assert_includes round.errors[:season], "can't be blank"
  end

  it 'validates name presence' do
    round = Round.new
    assert_not round.valid?, 'Round is valid without a name'
    assert_includes round.errors[:name], "can't be blank"
  end

  it 'validates uniqueness' do
    league_id = create(:league).id
    season = '2024'
    name = 'TestName'

    first_record = Round.create(name:, season:, league_id:)
    duplicate_record = Round.new(name:, season:, league_id:)

    assert first_record.valid?
    assert_not duplicate_record.valid?
    assert_equal ['has already been taken'], duplicate_record.errors[:name]
  end

end
