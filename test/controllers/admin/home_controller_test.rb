# frozen_string_literal: true

require 'test_helper'

module Admin
  class HomeControllerTest < ActionDispatch::IntegrationTest

    describe 'GET /admin' do
      it_succeeds_authenticated_as_admin do
        get admin_root_path
      end

      it 'routes to /admin' do
        assert_routing '/admin', controller: 'admin/home', action: 'index'
      end

      it_requires_authentication do
        get admin_root_path
      end

      it_requires_admin do
        get admin_root_path
      end
    end

  end
end
