# frozen_string_literal: true

module Session
  # Stores a new session.
  #
  # @param user [User] The user that will hold the session
  # @param request [Rack::Request, ActionDispatch::Request]
  class CreateService < Picks::Service

    def initialize(user, request)
      @user = user
      @request = request
    end

    def call
      request.session[Picks::Constants::SESSION_USER_CREDENTIALS_KEY] = user.session_token

      Picks::Event.notify(ActivityLog::SESSION_CREATE, user.email, user)
    end

    private

    attr_reader :user, :request

  end
end
