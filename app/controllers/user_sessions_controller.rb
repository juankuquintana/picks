# frozen_string_literal: true

class UserSessionsController < ApplicationController

  before_action :ensure_not_logged, only: %i[new google_login_callback]

  def new; end

  def google_login_callback
    auth = request.env['omniauth.auth'].info
    result = Session::GoogleAuthenticateInteractor.call(email: auth.email, name: auth.name, request:)

    if result.success?
      redirect_to result.redirect_url
    else
      render :new, notice: result.error
    end
  end

  def failure
    redirect_to '/500'
  end

  def destroy
    Session::DestroyService.call(current_user, request) if current_user

    redirect_to root_path
  end

end
