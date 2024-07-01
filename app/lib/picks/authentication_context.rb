# frozen_string_literal: true

module Picks
  class AuthenticationContext

    AUTHENTICATION_MODES = {
      login: { description: 'Traditional login flow', type: :login }
    }.freeze

    # @return [User]
    attr_reader :user
    # @return [Account]
    attr_reader :account
    # @return [Symbol] the mode used to authenticate
    attr_reader :mode

    # Factory is responsible for instantiating a new context, if the parameters are valid.
    #
    # @param user [User, nil] the authenticated user
    # @param account [Account, nil] the authenticated user primary account
    # @param mode [Symbol, nil] the mode used to authenticate.
    # @return [AuthenticationContext, nil] the context if authenticated, nil otherwise.
    def self.factory(user: nil, account: nil, mode: nil)
      return unless user || account || mode

      raise ArgumentError, "mode should be one of: #{AUTHENTICATION_MODES.keys} but is #{mode.inspect}" unless AUTHENTICATION_MODES.key?(mode)

      new(user, account, mode)
    end

    private

    # Initializes a new context. It is preferred to use {.factory} to create new instances.
    #
    # @param user [User]
    # @param account [Account]
    # @param mode [Symbol]
    def initialize(user, account, mode)
      @user = user
      @account = account
      @mode = mode
    end

  end
end
