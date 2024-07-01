# frozen_string_literal: true

module Session
  # Destroys the current user session.
  #
  # @param user [User] The authenticated user
  # @param request [Rack::Request, ActionDispatch::Request]
  class DestroyService < Picks::Service

    def initialize(user, request)
      @user = user
      @request = request
    end

    def call
      request.session[Picks::Constants::SESSION_USER_CREDENTIALS_KEY] = nil
      user.regenerate_session_token

      Picks::Event.notify(ActivityLog::SESSION_DESTROY, user.email, user)
    end

    private

    attr_reader :user, :request

  end
end
