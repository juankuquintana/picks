# frozen_string_literal: true

class RoundQuery

  include Picks::Query

  def self.find_first_round_from_round(round)
    scope.where(league_id: round.league_id, season: round.season, group: round.group).order(order: :asc).first
  end

end
