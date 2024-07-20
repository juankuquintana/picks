# frozen_string_literal: true

module ApiSports
  module Structs
    module Football
      class Fixture < Structs::Model

        # @return [BigDecimal]
        attr_accessor :id
        # @return [DateTime]
        attr_accessor :date
        # @return [BigDecimal]
        attr_accessor :home_team_id
        # @return [BigDecimal]
        attr_accessor :away_team_id
        # @return [Integer]
        attr_accessor :home_team_score
        # @return [Integer]
        attr_accessor :away_team_score
        # @return [String]
        attr_accessor :round
        # @return [String]
        attr_accessor :short_status
        # @return [Hash]
        attr_accessor :score

      end
    end
  end
end
