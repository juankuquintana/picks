# frozen_string_literal: true

class BetsController < AuthenticatedController

  def create
    bets_params[:fixture_id].each_with_index do |fixture_id, index|
      Rails.logger.debug fixture_id.inspect
      Rails.logger.debug bets_params[:home_team_score][index]
      Rails.logger.debug bets_params[:away_team_score][index]
    end
  end

  def update; end

  private

  def bets_params
    params.require(:bets).permit(home_team_score: [], fixture_id: [], away_team_score: [])
  end

end
