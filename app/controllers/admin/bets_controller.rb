# frozen_string_literal: true

module Admin
  class BetsController < ApplicationController

    def index
      @bets = Bet.order('id DESC').page(params[:page])
    end

  end
end
