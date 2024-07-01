# frozen_string_literal: true

module ApiSports
  module Structs
    module Football
      # Representation of a ApiSports Football::League::Fixtures result
      class FixturesResult < Structs::Result

        attr_accessor :fixtures

      end
    end
  end
end
