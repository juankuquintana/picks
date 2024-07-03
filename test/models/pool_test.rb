# frozen_string_literal: true

require 'test_helper'

class PoolTest < ActiveSupport::TestCase

  context 'associations' do
    should belong_to(:league).class_name('League')
    should belong_to(:round).class_name('Round')
  end

  context 'validations' do
    subject { build(:pool) }

    should validate_presence_of(:name)
    should validate_presence_of(:code)
    should validate_uniqueness_of(:code)
  end

end
