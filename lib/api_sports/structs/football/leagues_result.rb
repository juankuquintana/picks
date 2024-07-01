# frozen_string_literal: true

module ApiSports
  module Structs
    module Football
      # Representation of a ApiSports Football::League::Leagues result
      class LeaguesResult < Structs::Result

        attr_accessor :leagues

      end
    end
  end
end
