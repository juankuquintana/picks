# frozen_string_literal: true

require 'test_helper'

module Admin
  class LeaguesControllerTest < ActionDispatch::IntegrationTest

    describe 'GET /admin/leagues' do
      it_succeeds_authenticated_as_admin do
        get admin_leagues_path
      end

      it 'routes to /admin/leagues' do
        assert_routing '/admin/leagues', controller: 'admin/leagues', action: 'index'
      end

      it_requires_authentication do
        get admin_leagues_path
      end

      it_requires_admin do
        get admin_leagues_path
      end
    end

    describe 'GET /admin/leagues/:id' do
      before do
        @league = create(:league)
      end

      it_succeeds_authenticated_as_admin do
        get admin_league_path(@league.id)
      end

      it 'routes to /admin/leagues/:id' do
        assert_routing '/admin/leagues/3', controller: 'admin/leagues', action: 'show', id: '3'
      end

      it_requires_authentication do
        get admin_league_path(10)
      end

      it_requires_admin do
        get admin_league_path(@league.id)
      end
    end

  end
end
