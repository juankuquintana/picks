# frozen_string_literal: true

require 'test_helper'

class LeagueQueryTest < ActiveSupport::TestCase

  describe '#find_by_adapter_reference' do
    it 'succeeds' do
      league = create(:league, adapters: { Sports::Adapters::ApiSportsAdapter::KEY => 1 })
      found_league = described_class.find_by_adapter_reference(Sports::Adapters::ApiSportsAdapter::KEY, 1)
      assert_equal league, found_league, 'league not found by adapter reference'
    end
  end

end
