# frozen_string_literal: true

require 'test_helper'

class BetTest < ActiveSupport::TestCase

  context 'associations' do
    should belong_to(:user).class_name('User')
    should belong_to(:pool).class_name('Pool')
    should belong_to(:fixture).class_name('Fixture')
  end

  context 'validations' do
    subject { build(:bet) }

    should validate_presence_of(:home_team_score)
    should validate_presence_of(:away_team_score)
    should validate_uniqueness_of(:fixture_id).scoped_to(:pool_id, :user_id)
  end

end
