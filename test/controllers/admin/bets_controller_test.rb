# frozen_string_literal: true

require 'test_helper'

module Admin
  class BetsControllerTest < ActionDispatch::IntegrationTest

    describe 'GET /admin/bets' do
      it_succeeds_authenticated_as_admin do
        get admin_bets_path
      end

      it 'routes to /admin/bets' do
        assert_routing '/admin/bets', controller: 'admin/bets', action: 'index'
      end

      it_requires_authentication do
        get admin_bets_path
      end

      it_requires_admin do
        get admin_bets_path
      end
    end

  end
end
