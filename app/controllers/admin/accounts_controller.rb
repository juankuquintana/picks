# frozen_string_literal: true

module Admin
  class AccountsController < ApplicationController

    def index
      @accounts = Account.order('id DESC').page(params[:page])
    end

    def show
      @account = AccountQuery.find(params[:id])
      @activity_logs = ActivityLogQuery.account_activities_list(@account).page(1)
    end

  end
end
