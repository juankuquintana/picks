# frozen_string_literal: true

require 'test_helper'

class FixtureTest < ActiveSupport::TestCase

  it 'validates a datetime presence' do
    fixture = Fixture.new

    assert_not fixture.valid?, 'Account is valid without an email'

    assert_includes fixture.errors[:datetime], "can't be blank"
  end

  it 'validates adapters presence' do
    fixture = Fixture.new

    assert_not fixture.valid?, 'Account is valid without an email'

    assert_includes fixture.errors[:adapters], "can't be blank"
  end

end
