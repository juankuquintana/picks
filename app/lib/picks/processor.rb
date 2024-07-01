# frozen_string_literal: true

module Picks
  class Processor

    # @return [ApplicationRecord]
    attr_reader :item
    # @return [OrderItem]
    attr_reader :order_item
    # @return [String]
    attr_reader :actor

    # Creates a new processor passing the corresponding item to process.
    #
    # @param item [ApplicationRecord]
    # @param order_item [OrderItem]
    # @param actor [String]
    def initialize(item, order_item, actor = Picks::Constants::SYSTEM_ACTOR)
      @item = item
      @order_item = order_item
      @actor = actor
    end

    # Processes the item.
    #
    # @return [void]
    def process
      raise NotImplementedError
    end

    # Returns whether the item processing is finished successfully.
    #
    # @return [Boolean]
    def processed?
      raise NotImplementedError
    end

    # Returns whether the item processing is in a failed state.
    #
    # @return [Boolean]
    def failed?
      raise NotImplementedError
    end

    # Returns whether the item processing state is STATE_NEW.
    #
    # @return [Boolean]
    delegate :new?, to: :item

    # Returns whether the item processing state is STATE_PROCESSING.
    #
    # @return [Boolean]
    delegate :processing?, to: :item

    # Returns whether the item processing state is STATE_PROCESSED.
    #
    # @return [Boolean]
    delegate :processed?, to: :item

    # Returns whether the item processing state is STATE_CANCELLED.
    #
    # @return [Boolean]
    delegate :cancelled?, to: :item

    # Returns whether the item processing state is STATE_CANCELLING.
    #
    # @return [Boolean]
    delegate :cancelling?, to: :item

    def failure_description
      return nil unless failed?

      item.past_events.last.data['message']
    end

  end
end
