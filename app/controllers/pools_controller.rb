# frozen_string_literal: true

class PoolsController < AuthenticatedController

  def create
    result = Pools::CreateInteractor.call(name: params[:name], league_id: params[:league_id], user: current_user)

    if result.success?
      redirect_to home_url
    else
      redirect_to home_url, notice: result.error
    end
  end

end
