# frozen_string_literal: true

require 'test_helper'

class UserSessionsControllerTest < ActionDispatch::IntegrationTest

  describe 'GET /login' do
    it 'succeeds' do
      get login_url

      assert_response :success
    end

    it 'routes to /login' do
      assert_routing '/login', controller: 'user_sessions', action: 'new'
    end

    describe 'when authenticated' do
      it 'redirects to home' do
        sign_in_via_oauth_as_user

        get login_url

        assert_redirected_to home_path
      end
    end
  end

  describe 'GET /auth/google/callback' do
    it 'succeeds' do
      user = create(:user_with_account)
      Rails.application.env_config['omniauth.auth'] = oauth_mock(user, 'google')

      get '/auth/google/callback'

      assert_redirected_to home_path
    end

    it 'routes to /auth/google/callback' do
      assert_routing '/auth/google/callback', controller: 'user_sessions', action: 'google_login_callback',
                                              provider: 'google'
    end

    describe 'when authenticated' do
      it 'redirects to home' do
        sign_in_via_oauth_as_user

        get '/auth/google/callback'

        assert_redirected_to home_path
      end
    end
  end

  describe 'GET /auth/failure' do
    it 'succeeds' do
      sign_in_via_oauth_as_user

      get '/auth/failure'

      assert_redirected_to '/500'
    end

    it 'routes to /auth/failure' do
      assert_routing '/auth/failure', controller: 'user_sessions', action: 'failure'
    end

    describe 'when not authenticated' do
      it 'succeeds' do
        get '/auth/failure'

        assert_redirected_to '/500'
      end
    end
  end

  describe 'GET /logout' do
    it 'succeeds' do
      sign_in_via_oauth_as_user

      get logout_url

      assert_redirected_to root_path
    end

    it 'routes to /logout' do
      assert_routing '/logout', controller: 'user_sessions', action: 'destroy'
    end

    describe 'when not authenticated' do
      it 'succeeds' do
        get logout_url

        assert_redirected_to root_path
      end
    end
  end

end
