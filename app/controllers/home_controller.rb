# frozen_string_literal: true

class HomeController < AuthenticatedController

  def index
    @pools = current_user.pools
    return unless @pools.size == 1

    pool = @pools.first
    adapter_key, adapter_league_id = pool.league.adapter_data
    current_round_name = Sports::Adapters.get_league_current_round(adapter_key, adapter_league_id, pool.round.season)
    @round = Round.find_by(name: current_round_name, league: pool.league, season: pool.round.season)
    @fixtures = FixtureQuery.by_round(@round)
  end

end
