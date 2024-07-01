# frozen_string_literal: true

module Session
  # Creates a new session via Google, potentially creating a new user and it's associations.
  #
  # @param email [String] The authenticated user email
  # @param name [String] The authenticated user name
  # @param request [Rack::Request, ActionDispatch::Request]
  class GoogleAuthenticateService < Picks::Service

    def initialize(email, name, request)
      @email = email
      @name = name
      @request = request
    end

    def call
      user = User.find_by(email:) || User.new(email:)

      ApplicationRecord.transaction do
        user, is_new_user = signup_user(user)
        user.touch(:last_login_at) unless is_new_user
      end

      Session::CreateService.call(user, request)
    end

    private

    attr_reader :email, :name, :request

    def signup_user(user)
      return [user, false] if user.persisted?

      user.update!(passwordless: true)
      account = Account.create!(email:, name:)
      Membership.create!(user:, account:, primary: true)
      UserIdentity.create!(user:, email:, name: UserIdentity.names[:google])

      Picks::Event.notify(ActivityLog::USER_CREATE, user.email, user, account)

      [user, true]
    end

  end
end
