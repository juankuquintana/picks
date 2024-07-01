# frozen_string_literal: true

module ApiSports
  module Structs
    module Football
      # Representation of a ApiSports Football::Fixture::Rounds result
      class RoundsResult < Structs::Result

        attr_accessor :rounds

      end
    end
  end
end
