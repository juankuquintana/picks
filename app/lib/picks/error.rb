# frozen_string_literal: true

module Picks
  class Error

    # Notify the current exception notifiers.
    #
    # @param exception [Exception, String] the exception or message to notify
    # @return [void]
    def self.notify_exception(exception)
      Sentry.capture_exception(exception)
    end

  end
end
