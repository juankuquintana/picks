# frozen_string_literal: true

module Sports
  module Adapters

    ADAPTER_MAP = {
      Sports::Adapters::ApiSportsAdapter::KEY => Sports::Adapters::ApiSportsAdapter
    }.freeze

    class << self

      def get_league(adapter_key, id)
        raise ArgumentError, "Unsupported adapter #{adapter_key}" unless adapter_key == Sports::Adapters::ApiSportsAdapter::KEY

        Sports::Adapters::ApiSportsAdapter.get_league(id)
      end

      def get_league_rounds(adapter_key, league_id, season)
        raise ArgumentError, "Unsupported adapter #{adapter_key}" unless adapter_key == Sports::Adapters::ApiSportsAdapter::KEY

        Sports::Adapters::ApiSportsAdapter.get_league_rounds(league_id, season)
      end

    end

  end
end
