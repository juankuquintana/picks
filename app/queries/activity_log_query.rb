# frozen_string_literal: true

class ActivityLogQuery

  include Picks::Query

  # Selects the activity logs for the user, ordered by creation date.
  #
  # @param user [User]
  # @return [ActiveRecord::Relation]
  def self.user_activities_list(user)
    scope.where(user_id: user.id).order('created_at DESC')
  end

  # Selects the activity logs for the account, ordered by creation date.
  #
  # @param account [Account]
  # @return [ActiveRecord::Relation]
  def self.account_activities_list(account)
    scope.where(account_id: account.id).order('created_at DESC')
  end

  # Selects the activity logs for the bank account, ordered by creation date.
  #
  # @param bank_account [BankAccount]
  # @return [ActiveRecord::Relation]
  def self.bank_account_activities_list(bank_account)
    scope.where(bank_account_id: bank_account.id).order('created_at DESC')
  end

end
