# frozen_string_literal: true

class LeaguesController < AuthenticatedController

  def index
    @leagues = League.all
  end

end
