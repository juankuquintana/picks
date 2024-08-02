# frozen_string_literal: true

module Bets
  # Creates or updates a bet.
  #
  # @param user [User]
  # @param pool_id [BigDecimal] the pool ID
  # @param fixture_id [BigDecimal] the fixture ID
  # @param home_team_score [Integer] the home team score
  # @param away_team_score [Integer] the away team score
  class InsertService < Picks::Service

    def initialize(user, pool_id, fixture_id, home_team_score, away_team_score)
      @user = user
      @pool_id = pool_id
      @fixture_id = fixture_id
      @home_team_score = home_team_score
      @away_team_score = away_team_score
    end

    def call
      pool = @user.pools.find_by(id: @pool_id)
      raise ActiveRecord::RecordNotFound, 'Pool not found' unless pool

      fixture = Fixture.find(@fixture_id)
      raise ActiveRecord::RecordNotFound, 'Fixture not found' unless fixture && fixture.round.league == pool.league

      raise StandardError, 'Unable to create fixture without not started state' unless fixture.state == Fixture::STATE_NOT_STARTED

      ApplicationRecord.transaction do
        bet = Bet.create!(fixture:, pool:, user: @user, home_team_score: @home_team_score, away_team_score: @away_team_score)

        identifiers = { bet_id: bet.id, pool_id: pool.id, fixture_id: fixture.id }
        data = { home_team_score: @home_team_score, away_team_score: @away_team_score }
        Picks::Event.notify(ActivityLog::BET_INSERT, @user.email, @user, @user.primary_account, identifiers, data)
      end

      pool
    end

    private

    attr_reader :user, :pool_id, :fixture_id, :home_team_score, :away_team_score

  end
end
