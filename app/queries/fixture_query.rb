# frozen_string_literal: true

class FixtureQuery

  include Picks::Query

  def self.find_by_adapter_reference(key, value)
    scope.find_by('adapters @> ?', { key => value }.to_json)
  end

  def self.league_nearest_fixture(league_id)
    scope.joins(round: :league)
         .where(rounds: { league_id: })
         .where('fixtures.datetime >= ?', Time.now)
         .order('fixtures.datetime ASC')
         .first
  end

end
