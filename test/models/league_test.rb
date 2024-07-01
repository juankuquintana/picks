# frozen_string_literal: true

require 'test_helper'

class LeagueTest < ActiveSupport::TestCase

  it 'validates name presence' do
    league = League.new
    assert_not league.valid?, 'League is valid without a country'
    assert_includes league.errors[:country], 'must exist'
  end

  it 'validates logo presence' do
    league = League.new
    assert_not league.valid?, 'League is valid without a logo'
    assert_includes league.errors[:logo], "can't be blank"
  end

  it 'validates name presence' do
    league = League.new
    assert_not league.valid?, 'League is valid without a name'
    assert_includes league.errors[:name], "can't be blank"
  end

  it 'validates adapters presence' do
    league = League.new
    assert_not league.valid?, 'League is valid without a name'
    assert_includes league.errors[:adapters], "can't be blank"
  end

end
