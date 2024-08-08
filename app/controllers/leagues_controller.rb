# frozen_string_literal: true

class LeaguesController < AuthenticatedController

  def index
    @leagues = League.all
  end

  def show
    @league = League.find_by(parameterized_name: params[:league_name])
    season = @league.most_recent_season
    if params[:round]
      @round = Round.find_by(league: @league, id: params[:round])
    else
      adapter_key, adapter_league_id = @league.adapter_data
      current_round_name = Sports::Adapters.get_league_current_round(adapter_key, adapter_league_id, season)
      @round = Round.find_by(name: current_round_name, league: @league, season:)
    end
    @rounds = Round.where(league: @league, season:)
    @fixtures = FixtureQuery.by_round(@round)
  end

end
