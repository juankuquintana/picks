# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'minitest/autorun'
require 'minitest/spec'
require 'mocha/minitest'
require 'sidekiq/testing'
require 'webmock/minitest'

require 'support/fixture_helpers'

module ActiveSupport
  class TestCase

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    include FactoryBot::Syntax::Methods
    include FixtureHelpers

    Sidekiq::Testing.fake!
    Sidekiq.logger.level = Logger::WARN

  end
end

require 'support/controller_shared_test_helpers'
require 'support/controller_test_helpers'
require 'support/session_helpers'

module ActionDispatch
  class IntegrationTest

    include ControllerSharedTestHelpers
    include ControllerTestHelpers
    include SessionHelpers

  end
end

class InteractorStub

  attr_reader :success

  def initialize(success: true)
    @success = success
  end

  def success?
    @success
  end

end

class ServiceStub

  attr_reader :result

end
