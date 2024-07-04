# frozen_string_literal: true

module Pools
  # Creates a pool.
  #
  # @param name [String] Name of the pool
  # @param league_id [BigDecimal] the league ID
  # @param user [User]
  class CreateService < Picks::Service

    def initialize(name, league_id, user)
      @league_id = league_id
      @name = name
      @user = user
    end

    def call
      pool = nil
      round = RoundQuery.find_first_round_of_last_season(league_id)

      ApplicationRecord.transaction do
        pool = Pool.create!(name:, league_id:, code: SecureRandom.hex(10), round:)
        PoolUser.create!(user:, pool:, role: PoolUser::ROLE_ADMIN)
      end

      Picks::Event.notify(ActivityLog::POOL_CREATE, user.email, user, user.primary_account)

      pool
    end

    private

    attr_reader :league_id, :name, :user

  end
end
