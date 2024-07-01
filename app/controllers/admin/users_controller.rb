# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController

    def index
      @users = User.order('id DESC').page(params[:page])
    end

    def show
      @user = UserQuery.find(params[:id])
      @activity_logs = ActivityLogQuery.user_activities_list(@user).page(1)
    end

  end
end
