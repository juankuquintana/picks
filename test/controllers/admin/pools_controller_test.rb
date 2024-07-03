# frozen_string_literal: true

require 'test_helper'

module Admin
  class PoolsControllerTest < ActionDispatch::IntegrationTest

    describe 'GET /admin/pools' do
      it_succeeds_authenticated_as_admin do
        get admin_pools_path
      end

      it 'routes to /admin/pools' do
        assert_routing '/admin/pools', controller: 'admin/pools', action: 'index'
      end

      it_requires_authentication do
        get admin_pools_path
      end

      it_requires_admin do
        get admin_pools_path
      end
    end

  end
end
