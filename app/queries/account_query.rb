# frozen_string_literal: true

class AccountQuery

  include Picks::Query

  # Finds an account
  #
  # @example
  #
  #    AccountFinder.find(1)
  #    AccountFinder.find("1")
  #    AccountFinder.find("account@email.com")
  #
  # @see #find!
  #
  # @param  identifier [#to_i, String] the Account ID or Account email
  # @return [Account, nil]
  def self.find(identifier)
    case identifier
    when Integer, PATTERN_ID, LEADING_ID
      find_by_id(identifier)
    else
      find_by_email(identifier)
    end
  end

  # Finds an Account by ID.
  #
  # @param  identifier [#to_i] the Account ID
  # @return [Account, nil]
  def self.find_by_id(identifier)
    scope.where(id: identifier).first
  end

  # Finds an Account by email.
  # @param  identifier [String] the Account email address
  # @return [Account, nil]
  def self.find_by_email(identifier)
    query = identifier.to_s.downcase.strip
    scope.where(email: query).first
  end

end
