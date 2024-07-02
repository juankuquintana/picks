# frozen_string_literal: true

module Admin
  class FixturesController < ApplicationController

    def index
      @fixtures = Fixture.order('id DESC').page(params[:page])
    end

    def show
      @fixture = Fixture.find(params[:id])
    end

  end
end
