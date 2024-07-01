# frozen_string_literal: true

module Admin
  class CountriesController < ApplicationController

    def index
      @countries = Country.order('id DESC').page(params[:page])
    end

  end
end
