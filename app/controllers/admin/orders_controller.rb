# frozen_string_literal: true

module Admin
  class OrdersController < ApplicationController

    def index
      @orders = Order.order('id DESC').page(params[:page])
    end

    def show
      @order = Order.find(params[:id])
    end

  end
end
