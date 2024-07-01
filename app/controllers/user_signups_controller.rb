# frozen_string_literal: true

class UserSignupsController < ApplicationController

  before_action :ensure_not_logged, only: %i[new]

  def new; end

end
