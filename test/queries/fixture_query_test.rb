# frozen_string_literal: true

require 'test_helper'

class FixtureQueryTest < ActiveSupport::TestCase

  describe '#find_by_adapter_reference' do
    it 'succeeds' do
      fixture = create(:fixture, adapters: { Sports::Adapters::ApiSportsAdapter::KEY => 1 })
      found_fixture = described_class.find_by_adapter_reference(Sports::Adapters::ApiSportsAdapter::KEY, 1)
      assert_equal fixture, found_fixture, 'fixture not found by adapter reference'
    end
  end

end
