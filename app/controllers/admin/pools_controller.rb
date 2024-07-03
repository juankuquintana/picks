# frozen_string_literal: true

module Admin
  class PoolsController < ApplicationController

    def index
      @pools = Pool.order('id DESC').page(params[:page])
    end

  end
end
