# frozen_string_literal: true

module ApiSports
  module Structs
    class Result < Structs::Model

      # default attributes
      attr_accessor :errors
      # list attributes
      attr_accessor :count
      attr_accessor :page, :total_pages

    end
  end
end
