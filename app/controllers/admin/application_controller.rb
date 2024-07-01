# frozen_string_literal: true

module Admin
  class ApplicationController < ::ApplicationController

    include AdminControllerConcern

    before_action :require_authentication
    before_action :require_admin

    layout 'admin'

  end
end
