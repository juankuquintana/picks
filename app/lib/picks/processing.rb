# frozen_string_literal: true

module Picks
  module Processing

    # Determines the correct processor class for a item and initializes a new instance of the processor.
    #
    # @param item [ActiveRecord::Base]
    # @param order_item [OrderItem]
    # @param actor [String]
    # @return [Picks::Processor]
    def self.processor(item, order_item, actor = Picks::Constants::SYSTEM_ACTOR)
      processor_class(item).new(item, order_item, actor)
    end

    def self.processor_class(item)
      case item
      when BankStatementUpload
        BankStatementUploadProcessor
      else
        raise(ArgumentError, "Unknown processor for item `#{item.class.name}`")
      end
    end

  end
end
