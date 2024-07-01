# frozen_string_literal: true

require 'test_helper'

class AccountQueryTest < ActiveSupport::TestCase

  describe '#find' do
    it 'finds account by ID' do
      account = create(:account)
      found_account = described_class.find(account.id)
      assert_equal account, found_account, 'account not found by ID'
    end

    it 'finds account by email' do
      account = create(:account)
      found_account = described_class.find(account.email)
      assert_equal account, found_account, 'account not found by email'
    end

    it 'returns nil when account not found' do
      found_account = described_class.find('nonexistent_email@example.com')
      assert_nil found_account, 'account should not be found'
    end
  end

end
