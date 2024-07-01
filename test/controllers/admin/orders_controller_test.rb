# frozen_string_literal: true

require 'test_helper'

module Admin
  class OrdersControllerTest < ActionDispatch::IntegrationTest

    before do
      @order = create(:order)
    end

    describe 'GET /admin/orders' do
      it_succeeds_authenticated_as_admin do
        get admin_orders_path
      end

      it 'routes to /admin/orders' do
        assert_routing '/admin/orders', controller: 'admin/orders', action: 'index'
      end

      it_requires_authentication do
        get admin_orders_path
      end

      it_requires_admin do
        get admin_orders_path
      end
    end

    describe 'GET /admin/orders/:id' do
      it_succeeds_authenticated_as_admin do
        get admin_order_path(@order.id)
      end

      it 'routes to /admin/orders/:id' do
        assert_routing '/admin/orders/3', controller: 'admin/orders', action: 'show', id: '3'
      end

      it_requires_authentication do
        get admin_order_path(3)
      end

      it_requires_admin do
        get admin_order_path(@order.id)
      end
    end

  end
end
