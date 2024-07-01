# frozen_string_literal: true

module ApiSports
  module Structs
    module Football
      # Representation of a ApiSports Football::League::Leagues result
      class TeamsResult < Structs::Result

        attr_accessor :teams

      end
    end
  end
end
