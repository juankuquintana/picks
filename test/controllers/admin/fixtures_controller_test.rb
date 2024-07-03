# frozen_string_literal: true

require 'test_helper'

module Admin
  class FixturesControllerTest < ActionDispatch::IntegrationTest

    describe 'GET /admin/fixtures' do
      it_succeeds_authenticated_as_admin do
        get admin_fixtures_path
      end

      it 'routes to /admin/fixtures' do
        assert_routing '/admin/fixtures', controller: 'admin/fixtures', action: 'index'
      end

      it_requires_authentication do
        get admin_fixtures_path
      end

      it_requires_admin do
        get admin_fixtures_path
      end
    end

    describe 'GET /admin/fixtures/:id' do
      before do
        @fixture = create(:fixture)
      end

      it_succeeds_authenticated_as_admin do
        get admin_fixture_path(@fixture.id)
      end

      it 'routes to /admin/fixtures/:id' do
        assert_routing '/admin/fixtures/3', controller: 'admin/fixtures', action: 'show', id: '3'
      end

      it_requires_authentication do
        get admin_fixture_path(10)
      end

      it_requires_admin do
        get admin_fixture_path(@fixture.id)
      end
    end

  end
end
