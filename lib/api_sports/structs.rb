# frozen_string_literal: true

module ApiSports
  module Structs
    # The model represents the basic abstraction for the Struct.
    #
    # It contains the common initializer, and the base methods
    # to be used to deal with the various data types.
    class Model

      # Initializes the struct from a Hash of attributes.
      #
      # @param  attributes [Hash] the attributes to set
      def initialize(attributes = {})
        assign(attributes) if attributes
        yield self if block_given?
      end

      # Assigns the attributes from a Hash.
      #
      # If an attribute setter doesn't exist for a Hash key,
      # the item is silently ignored.
      #
      # @param  attributes [Hash] the attributes to set
      # @return [void]
      def assign(attributes)
        attributes.each do |key, value|
          send(:"#{key}=", value) if respond_to?(:"#{key}=")
        end
      end

    end
  end
end

require_relative 'structs/result'

# models
require_relative 'structs/country'
require_relative 'structs/football/fixture'
require_relative 'structs/league'

# results
require_relative 'structs/football/fixtures_result'
require_relative 'structs/football/leagues_result'
require_relative 'structs/football/rounds_result'
