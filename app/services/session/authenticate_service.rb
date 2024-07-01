# frozen_string_literal: true

module Session
  # Authenticates a user session by it's session token.
  #
  # @param request [Rack::Request, ActionDispatch::Request]
  # @returns [User] request [Rack::Request, ActionDispatch::Request]
  class AuthenticateService < Picks::Service

    def initialize(request)
      @request = request
    end

    def call
      user = nil
      if (session_token = request.session[Picks::Constants::SESSION_USER_CREDENTIALS_KEY])
        user = User.find_by(session_token:)
      end

      user
    end

    private

    attr_reader :request

  end
end
