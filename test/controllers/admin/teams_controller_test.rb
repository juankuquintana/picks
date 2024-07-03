# frozen_string_literal: true

require 'test_helper'

module Admin
  class TeamsControllerTest < ActionDispatch::IntegrationTest

    describe 'GET /admin/teams' do
      it_succeeds_authenticated_as_admin do
        get admin_teams_path
      end

      it 'routes to /admin/teams' do
        assert_routing '/admin/teams', controller: 'admin/teams', action: 'index'
      end

      it_requires_authentication do
        get admin_teams_path
      end

      it_requires_admin do
        get admin_teams_path
      end
    end

    describe 'GET /admin/teams/:id' do
      before do
        @team = create(:team)
      end

      it_succeeds_authenticated_as_admin do
        get admin_team_path(@team.id)
      end

      it 'routes to /admin/teams/:id' do
        assert_routing '/admin/teams/3', controller: 'admin/teams', action: 'show', id: '3'
      end

      it_requires_authentication do
        get admin_team_path(10)
      end

      it_requires_admin do
        get admin_team_path(@team.id)
      end
    end

  end
end
