# frozen_string_literal: true

require 'test_helper'

class SiteControllerTest < ActionDispatch::IntegrationTest

  describe 'GET /' do
    it 'succeeds' do
      get root_url

      assert_response :success
    end

    it 'routes to /' do
      assert_routing '/', controller: 'site', action: 'index'
    end

    describe 'when not authenticated' do
      it 'succeeds' do
        get root_url

        assert_response :success
      end
    end
  end

  describe 'GET /privacy' do
    it 'succeeds' do
      get privacy_url

      assert_response :success
    end

    it 'routes to /privacy' do
      assert_routing '/privacy', controller: 'site', action: 'privacy'
    end

    describe 'when not authenticated' do
      it 'succeeds' do
        get privacy_url

        assert_response :success
      end
    end
  end

end
