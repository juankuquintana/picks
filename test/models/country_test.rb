# frozen_string_literal: true

require 'test_helper'

class CountryTest < ActiveSupport::TestCase

  it 'validates name presence' do
    country = Country.new
    assert_not country.valid?, 'Country is valid without a name'
    assert_includes country.errors[:name], "can't be blank"
  end

end
