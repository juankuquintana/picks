# frozen_string_literal: true

require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  it 'validates user association' do
    user = create(:user)
    order = create(:order, user:)
    assert_equal user, order.user
  end

  it 'validates account association' do
    account = create(:account)
    order = create(:order, account:)
    assert_equal account, order.account
  end

end
