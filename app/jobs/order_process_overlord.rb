# frozen_string_literal: true

class OrderProcessOverlord

  include Sidekiq::Job

  def perform
    Picks::Logger.logi('workers.order_process_overlord.started')

    OrderQuery.needs_processing.each do |order|
      OrderProcessWorker.perform_async(order.id)
    end

    Picks::Logger.logi('workers.order_process_overlord.completed')
  end

end
