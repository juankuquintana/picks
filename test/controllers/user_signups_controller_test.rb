# frozen_string_literal: true

require 'test_helper'

class UserSignupsControllerTest < ActionDispatch::IntegrationTest

  describe 'GET /signup' do
    it 'succeeds' do
      get signup_url

      assert_response :success
    end

    it 'routes to /signup' do
      assert_routing '/signup', controller: 'user_signups', action: 'new'
    end

    describe 'when authenticated' do
      it 'redirects to home' do
        sign_in_via_oauth_as_user

        get signup_url

        assert_redirected_to home_path
      end
    end
  end

end
