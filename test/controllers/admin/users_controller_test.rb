# frozen_string_literal: true

require 'test_helper'

module Admin
  class UsersControllerTest < ActionDispatch::IntegrationTest

    describe 'GET /admin/users' do
      it_succeeds_authenticated_as_admin do
        get admin_users_path
      end

      it 'routes to /admin/users' do
        assert_routing '/admin/users', controller: 'admin/users', action: 'index'
      end

      it_requires_authentication do
        get admin_users_path
      end

      it_requires_admin do
        get admin_users_path
      end
    end

    describe 'GET /admin/users/:id' do
      it_succeeds_authenticated_as_admin do
        get admin_user_path(@user.email)
      end

      describe 'when passing an ID' do
        it_succeeds_authenticated_as_admin do
          get admin_user_path(@user.id)
        end
      end

      it 'routes to /admin/users/:id' do
        assert_routing '/admin/users/3', controller: 'admin/users', action: 'show', id: '3'
      end

      it_requires_authentication do
        get admin_user_path('user@email.com')
      end

      it_requires_admin do
        get admin_user_path(@user.email)
      end
    end

  end
end
