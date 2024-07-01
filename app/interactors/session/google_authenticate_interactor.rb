# frozen_string_literal: true

module Session
  class GoogleAuthenticateInteractor < Actor

    include Rails.application.routes.url_helpers

    # @param email [String] The authenticated user email
    input :email
    # @param name [String] The authenticated user name
    input :name
    # @param request [Rack::Request, ActionDispatch::Request]
    input :request
    # @return [String] The URL the user will be redirected to
    output :redirect_url

    def call
      result.redirect_url = home_path

      Session::GoogleAuthenticateService.call(email, name, request)
    end

  end
end
