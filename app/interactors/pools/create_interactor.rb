# frozen_string_literal: true

module Pools
  class CreateInteractor < Actor

    # @param name [String] The authenticated user name
    input :name
    # @param league_id [BigDecimal]
    input :league_id
    # @param user [User]
    input :user
    # @return [Pool] The newly created pool
    output :pool

    def call
      result.pool = Pools::CreateService.call(name, league_id, user)
    rescue ActiveRecord::RecordInvalid => exception
      Picks::Logger.loge('interactors.pools.create_interactor.failed', exception:)
      Picks::Error.notify_exception(exception)

      fail!(error: exception.message)
    end

  end
end
