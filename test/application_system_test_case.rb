# frozen_string_literal: true

require 'test_helper'
require 'capybara/cuprite'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase

  include SessionHelpers

  driven_by :cuprite, using: :headless_chrome

  before do
    Capybara.app_host = 'http://0.0.0.0:3000'
    Capybara.server_port = 3000
    Capybara.always_include_port = true

    Capybara.default_max_wait_time = 5
    Capybara.disable_animation = true

    WebMock.disable_net_connect!(allow: [/__identify__/, %r{json/version}])
  end

end
