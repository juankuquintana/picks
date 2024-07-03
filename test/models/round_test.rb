# frozen_string_literal: true

require 'test_helper'

class RoundTest < ActiveSupport::TestCase

  context 'associations' do
    should have_many(:pools)
  end

  context 'validations' do
    subject { build(:round) }

    should validate_presence_of(:name)
    should validate_presence_of(:season)
    should validate_uniqueness_of(:name).scoped_to(:season, :league_id).case_insensitive
  end

end
