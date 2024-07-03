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

end
