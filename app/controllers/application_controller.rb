# frozen_string_literal: true

class ApplicationController < ActionController::Base

  layout 'site'

  include AuthenticationControllerConcern

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_sentry_context

  def set_sentry_context
    Sentry.set_user(email: current_user.email) if logged_in?
  end

end
