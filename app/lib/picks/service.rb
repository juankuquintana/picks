# frozen_string_literal: true

module Picks
  class Service

    attr_reader :result

    class << self

      def call(*args)
        new(*args).tap do |service|
          service.instance_variable_set(
              :@result,
              service.call
            )
        end
      end

    end

    def call
      raise NotImplementedError
    end

    def log_event!(item, event_type, data = {}, actor = Picks::Constants::SYSTEM_ACTOR)
      ItemEvent.create!(
          actor:,
          item:,
          event_type:,
          data:
        )

      item.sync_state
    end

  end
end
