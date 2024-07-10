# frozen_string_literal: true

require 'test_helper'

class OrderProcessOverlordTest < ActiveSupport::TestCase

  describe '#perform' do
    it 'queues the job' do
      described_class.jobs.clear

      described_class.perform_async

      assert_equal described_class.jobs.size, 1
    end

    it 'queues the OrderProcessWorker' do
      OrderProcessWorker.jobs.clear
      create(:order, state: Order::STATE_NEW)

      described_class.new.perform

      assert_equal OrderProcessWorker.jobs.size, 1
    end

    it 'logs the worker' do
      Picks::Logger.expects(:logi).with('jobs.order_process_overlord.started')
      Picks::Logger.expects(:logi).with('jobs.order_process_overlord.completed')

      described_class.new.perform
    end
  end

end
