# frozen_string_literal: true

module Picks
  class Event

    # Creates an ActivityLog.
    #
    # @param name [String]
    # @param actor [String]
    # @param user [User]
    # @param account [Account]
    # @param identifiers [Hash]
    # @param data [Hash]
    def self.notify(name, actor, user = nil, account = nil, identifiers = nil, data = nil)
      log(name, actor, user, account, identifiers, data)
    end

    class << self

      private

      def log(name, actor, user = nil, account = nil, identifiers = nil, data = nil)
        ActivityLog.create!(name:, actor:, user:, account:, identifiers:, data:)
      end

    end

  end
end
