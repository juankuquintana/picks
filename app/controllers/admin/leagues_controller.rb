# frozen_string_literal: true

module Admin
  class LeaguesController < ApplicationController

    def index
      @leagues = League.order('id DESC').page(params[:page])
    end

    def show
      @league = League.find(params[:id])
    end

  end
end
