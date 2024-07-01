# frozen_string_literal: true

require 'active_support/concern'

module ControllerSharedTestHelpers

  extend ActiveSupport::Concern

  class_methods do
    def it_succeeds_authenticated_as_user(&block)
      it 'succeeds' do
        @user = create(:user_with_account)
        sign_in_via_oauth_as(@user)

        instance_eval(&block) if block

        assert_response :success
      end
    end

    def it_succeeds_authenticated_as_admin(&block)
      it 'succeeds' do
        @user = create(:admin_with_account)
        sign_in_via_oauth_as(@user)

        instance_eval(&block) if block

        assert_response :success
      end
    end

    def it_redirects_authenticated_as_user(&block)
      it 'succeeds' do
        @user = create(:user_with_account)
        sign_in_via_oauth_as(@user)

        instance_eval(&block) if block

        assert_response :redirect
      end
    end

    def it_requires_authentication(&block)
      describe 'when not authenticated' do
        it 'redirects to login' do
          instance_eval(&block) if block

          assert_redirected_to login_path
        end
      end
    end

    def it_requires_admin(&block)
      describe 'when not admin' do
        it 'redirects to login' do
          @user = create(:user_with_account)
          sign_in_via_oauth_as(@user)

          instance_eval(&block) if block

          assert_redirected_to login_path
        end
      end
    end
  end

end
