# frozen_string_literal: true

class AuthenticatedController < ApplicationController

  layout 'application'

  before_action :require_authentication

end
