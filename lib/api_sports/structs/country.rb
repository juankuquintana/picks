# frozen_string_literal: true

module ApiSports
  module Structs
    class Country < Structs::Model

      # @return [String]
      attr_accessor :name
      # @return [String]
      attr_accessor :code
      # @return [String]
      attr_accessor :flag

    end
  end
end
