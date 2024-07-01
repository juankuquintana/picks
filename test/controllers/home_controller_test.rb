# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  describe 'GET /home' do
    it_succeeds_authenticated_as_user do
      get home_path
    end

    it 'routes to /home' do
      assert_routing '/home', controller: 'home', action: 'index'
    end

    it_requires_authentication do
      get home_path
    end
  end

end
