# frozen_string_literal: true

require 'test_helper'

class OrderProcessWorkerTest < ActiveSupport::TestCase

  describe '#perform' do
    it 'queues the job' do
      described_class.jobs.clear

      described_class.perform_async

      assert_equal described_class.jobs.size, 1
    end

    it 'delegates to OrderProcessService' do
      order = create(:order)

      OrderProcessService.expects(:call).with(order.id)

      described_class.new.perform(order.id)
    end

    it 'logs the worker' do
      OrderProcessService.stubs(:call)

      order = create(:order)

      Picks::Logger.expects(:logi).with('jobs.order_process_worker.started', order_id: order.id)
      Picks::Logger.expects(:logi).with('jobs.order_process_worker.completed', order_id: order.id)

      described_class.new.perform(order.id)
    end
  end

end
