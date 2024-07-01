# frozen_string_literal: true

require 'test_helper'

module Admin
  class AccountsControllerTest < ActionDispatch::IntegrationTest

    describe 'GET /admin/accounts' do
      it_succeeds_authenticated_as_admin do
        get admin_accounts_path
      end

      it 'routes to /admin/accounts' do
        assert_routing '/admin/accounts', controller: 'admin/accounts', action: 'index'
      end

      it_requires_authentication do
        get admin_accounts_path
      end

      it_requires_admin do
        get admin_accounts_path
      end
    end

    describe 'GET /admin/accounts/:id' do
      it_succeeds_authenticated_as_admin do
        get admin_account_path(@user.primary_account.email)
      end

      describe 'when passing an ID' do
        it_succeeds_authenticated_as_admin do
          get admin_account_path(@user.primary_account.id)
        end
      end

      it 'routes to /admin/accounts/:id' do
        assert_routing '/admin/accounts/3', controller: 'admin/accounts', action: 'show', id: '3'
      end

      it_requires_authentication do
        get admin_account_path('user@email.com')
      end

      it_requires_admin do
        get admin_account_path(@user.primary_account.email)
      end
    end

  end
end
