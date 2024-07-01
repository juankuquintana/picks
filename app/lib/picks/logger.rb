# frozen_string_literal: true

# Custom logger of the application. As first key use the module and the class name.
#
# Example of usage:
#
#    Picks::Logger.logi('interactors.session.google_authenticate_interactor', 'Hello, Rails Logger from an interactor!')
#    Picks::Logger.logi('services.session.authenticate_service', 'Hello, Rails Logger from a service!')
#    Picks::Logger.logi('workers.hard_worker', 'Hello, Rails Logger from a worker!')
#
module Picks
  class Logger

    # Log a debug message.
    #
    # @see #log
    def self.logd(tag, data)
      log(tag:, data:, level: :debug)
    end

    # Log an info message.
    #
    # @see #log
    def self.logi(tag, data = nil)
      log(tag:, data:, level: :info)
    end

    # Log a warning message.
    #
    # @see #log
    def self.logw(tag, data)
      data = extract_exception(data)

      log(tag:, data:, level: :warn)
    end

    # Log an error message.
    #
    # @see #log
    def self.loge(tag, data)
      data = extract_exception(data)

      log(tag:, data:, level: :error)
    end

    class << self

      private

      # Log the message to the current logger.
      #
      # @param level [Symbol]
      # @param tag [String]
      # @param data [String, Hash] the message or payload to log
      # @return [void]
      def log(tag:, data:, level:)
        Rails.logger.send(level, format('[%{tag}] %{data}', tag:, data: data.inspect))
      end

      def extract_exception(data)
        return data unless data.is_a?(Hash)
        return data unless (exception = data[:exception])

        { errmsg: exception.message, errclass: exception.class }
            .merge(data)
            .except!(:exception)
      end

    end

  end
end
