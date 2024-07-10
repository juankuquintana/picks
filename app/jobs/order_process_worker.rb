# frozen_string_literal: true

class OrderProcessWorker

  include Sidekiq::Job

  def perform(order_id)
    Picks::Logger.logi('jobs.order_process_worker.started', order_id:)

    OrderProcessService.call(order_id)

    Picks::Logger.logi('jobs.order_process_worker.completed', order_id:)
  end

end
