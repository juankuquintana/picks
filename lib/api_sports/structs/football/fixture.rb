# frozen_string_literal: true

module ApiSports
  module Structs
    module Football
      class Fixture < Structs::Model

        # @return [BigDecimal]
        attr_accessor :id
        # @return [DateTime]
        attr_accessor :date

      end
    end
  end
end
