# frozen_string_literal: true

module ApiSports
  module Structs
    class League < Structs::Model

      # @return [BigDecimal]
      attr_accessor :id
      # @return [String]
      attr_accessor :name
      # @return [String]
      attr_accessor :type
      # @return [String]
      attr_accessor :logo
      # @return [ApiSports::Structs::Country]
      attr_accessor :country
      # @return [Date]
      attr_accessor :season_start
      # @return [Date]
      attr_accessor :season_end

    end
  end
end
