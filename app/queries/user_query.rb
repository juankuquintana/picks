# frozen_string_literal: true

class UserQuery

  include Picks::Query

  # Finds a user
  #
  # @example
  #
  #    UserFinder.find(1)
  #    UserFinder.find("1")
  #    UserFinder.find("user@email.com")
  #
  # @see #find!
  #
  # @param  identifier [#to_i, String] the User ID or User email
  # @return [User, nil]
  def self.find(identifier)
    case identifier
    when Integer, PATTERN_ID, LEADING_ID
      find_by_id(identifier)
    else
      find_by_email(identifier)
    end
  end

  # Finds a User by ID.
  #
  # @param  identifier [#to_i] the User ID
  # @return [User, nil]
  def self.find_by_id(identifier)
    scope.where(id: identifier).first
  end

  # Finds a User by email.
  # @param  identifier [String] the User email address
  # @return [User, nil]
  def self.find_by_email(identifier)
    query = identifier.to_s.downcase.strip
    scope.where(email: query).first
  end

end
