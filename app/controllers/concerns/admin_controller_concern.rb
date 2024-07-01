# frozen_string_literal: true

module AdminControllerConcern

  extend ActiveSupport::Concern

  def require_admin
    return if logged_in? && current_user.admin?

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

end
