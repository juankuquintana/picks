# frozen_string_literal: true

module ControllerTestHelpers

  def setup
    super

    OmniAuth.config.test_mode = true
  end

  def teardown
    super

    OmniAuth.config.test_mode = false
  end

end
