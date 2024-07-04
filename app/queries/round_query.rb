# frozen_string_literal: true

class RoundQuery

  include Picks::Query

  def self.find_first_round_of_last_season(league_id)
    scope.where(league_id:).order(season: :desc, order: :asc).first
  end

end
