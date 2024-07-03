# frozen_string_literal: true

require 'test_helper'

module Admin
  class CountriesControllerTest < ActionDispatch::IntegrationTest

    describe 'GET /admin/countries' do
      it_succeeds_authenticated_as_admin do
        get admin_countries_path
      end

      it 'routes to /admin/countries' do
        assert_routing '/admin/countries', controller: 'admin/countries', action: 'index'
      end

      it_requires_authentication do
        get admin_countries_path
      end

      it_requires_admin do
        get admin_countries_path
      end
    end

  end
end
