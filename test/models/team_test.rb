# frozen_string_literal: true

require 'test_helper'

class TeamTest < ActiveSupport::TestCase

  it 'validates name presence' do
    team = Team.new
    assert_not team.valid?, 'Team is valid without a country'
    assert_includes team.errors[:name], "can't be blank"
  end

  it 'validates adapters presence' do
    team = Team.new
    assert_not team.valid?, 'Team is valid without a name'
    assert_includes team.errors[:adapters], "can't be blank"
  end

end
