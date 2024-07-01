# frozen_string_literal: true

module AuthenticationControllerConcern

  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :logged_in?
  end

  # Returns the authenticated user.
  #
  # @return [User, nil]
  def current_user
    authentication_context&.user
  end

  # Checks whether current user is logged in.
  #
  # Returns Boolean.
  def logged_in?
    return true if current_user

    false
  end

  def require_authentication
    return if logged_in?

    respond_to do |format|
      format.html do
        if request.xhr?
          head :unauthorized
        else
          redirect_to login_url, alert: I18n.t('message_error.authentication_failed')
        end
      end
    end

    nil
  end

  def ensure_not_logged
    return unless logged_in?

    redirect_to home_path
  end

  private

  # @return [Picks::AuthenticationContext, nil]
  def authentication_context
    return @authentication_context if defined?(@authentication_context)

    mode = Picks::AuthenticationContext::AUTHENTICATION_MODES[:login][:type]
    user, account = authenticate_via_session
    @authentication_context = Picks::AuthenticationContext.factory(user:, account:, mode:)
  end

  def authenticate_via_session
    user = Session::AuthenticateService.call(request).result
    [user, user&.primary_account]
  end

end
