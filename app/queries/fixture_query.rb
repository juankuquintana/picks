# frozen_string_literal: true

class FixtureQuery

  include Picks::Query

  def self.find_by_adapter_reference(key, value)
    scope.find_by('adapters @> ?', { key => value }.to_json)
  end

end
