# frozen_string_literal: true

module ApiSports
  module Structs
    module Football
      # Representation of a ApiSports Football::League::Seasons result
      class SeasonsResult < Structs::Result

        attr_accessor :years

      end
    end
  end
end
