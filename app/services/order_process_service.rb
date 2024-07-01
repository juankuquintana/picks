# frozen_string_literal: true

# Processes an order.
#
# @param order_id [Integer]
class OrderProcessService < Picks::Service

  def initialize(order_id)
    @order_id = order_id
  end

  def call
    order = Order.find(order_id)
    process_order(order)
  end

  private

  attr_reader :order_id

  def process_order(order)
    order_items = order.order_items
    return if order_items.empty?

    order_items.each do |order_item|
      process_order_item(order_item)
    end

    order.sync_state
    order.update!(last_processed_at: Time.current, runs: order.runs + 1)
  end

  def process_order_item(order_item)
    processor = Picks::Processing.processor(order_item.order_item, order_item)
    processor.process

    order_item.failure_description = nil if processor.new? || processor.processing? || processor.processed?
    order_item.failure_description = processor.failure_description if processor.failed?
    order_item.state = determine_state(processor)
    order_item.save!
  end

  def determine_state(processor)
    if processor.failed?
      OrderItem::STATE_FAILED
    elsif processor.new?
      OrderItem::STATE_NEW
    elsif processor.processing? || processor.cancelling?
      OrderItem::STATE_PROCESSING
    elsif processor.processed?
      OrderItem::STATE_PROCESSED
    elsif processor.cancelled?
      OrderItem::STATE_CANCELLED
    else
      raise StandardError, "Unsupported OrderItem state for order: #{order_id}"
    end
  end

end
