# frozen_string_literal: true

module ApiSports
  module Structs
    class Team < Structs::Model

      # @return [BigDecimal]
      attr_accessor :id
      # @return [String]
      attr_accessor :name
      # @return [String]
      attr_accessor :code
      # @return [String]
      attr_accessor :logo

    end
  end
end
