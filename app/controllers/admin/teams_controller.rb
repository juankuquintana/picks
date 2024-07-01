# frozen_string_literal: true

module Admin
  class TeamsController < ApplicationController

    def index
      @teams = Team.order('id DESC').page(params[:page])
    end

    def show
      @team = Team.find(params[:id])
    end

  end
end
