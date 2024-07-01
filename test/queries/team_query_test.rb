# frozen_string_literal: true

require 'test_helper'

class TeamQueryTest < ActiveSupport::TestCase

  describe '#find_by_adapter_reference' do
    it 'succeeds' do
      team = create(:team, adapters: { Sports::Adapters::ApiSportsAdapter::KEY => 1 })
      found_team = described_class.find_by_adapter_reference(Sports::Adapters::ApiSportsAdapter::KEY, 1)
      assert_equal team, found_team, 'team not found by adapter reference'
    end
  end

end
