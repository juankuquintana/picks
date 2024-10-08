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

      def get_current_league(adapter_key, id)
        raise ArgumentError, "Unsupported adapter #{adapter_key}" unless adapter_key == Sports::Adapters::ApiSportsAdapter::KEY

        Sports::Adapters::ApiSportsAdapter.get_current_league(id)
      end

      def get_league_rounds(adapter_key, league_id, season)
        raise ArgumentError, "Unsupported adapter #{adapter_key}" unless adapter_key == Sports::Adapters::ApiSportsAdapter::KEY

        Sports::Adapters::ApiSportsAdapter.get_league_rounds(league_id, season)
      end

      def get_league_current_round(adapter_key, league_id, season)
        raise ArgumentError, "Unsupported adapter #{adapter_key}" unless adapter_key == Sports::Adapters::ApiSportsAdapter::KEY

        Sports::Adapters::ApiSportsAdapter.get_league_current_round(league_id, season)
      end

      def get_league_teams(adapter_key, league_id, season)
        raise ArgumentError, "Unsupported adapter #{adapter_key}" unless adapter_key == Sports::Adapters::ApiSportsAdapter::KEY

        Sports::Adapters::ApiSportsAdapter.get_league_teams(league_id, season)
      end

      def get_league_fixtures(adapter_key, league_id, season)
        raise ArgumentError, "Unsupported adapter #{adapter_key}" unless adapter_key == Sports::Adapters::ApiSportsAdapter::KEY

        Sports::Adapters::ApiSportsAdapter.get_league_fixtures(league_id, season)
      end

      def get_today_fixtures(adapter_key)
        raise ArgumentError, "Unsupported adapter #{adapter_key}" unless adapter_key == Sports::Adapters::ApiSportsAdapter::KEY

        Sports::Adapters::ApiSportsAdapter.get_today_fixtures
      end

    end

  end
end
