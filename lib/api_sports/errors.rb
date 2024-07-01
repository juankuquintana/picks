# frozen_string_literal: true

module ApiSports

  module Errors
  end

  module Error
  end

  class ApiSportsError < StandardError

    include Error

  end

  # A unified error for failed connections.
  class ConnectionError < ApiSportsError
  end

  # A unified error for SSL errors.
  class SSLError < ApiSportsError
  end

  # A unified error for authentication errors.
  class AuthenticationError < ApiSportsError
  end

end
