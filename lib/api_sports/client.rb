# frozen_string_literal: true

require_relative 'errors'
require 'faraday'

module ApiSports
  class Client

    class << self

      attr_accessor :default_client

    end

    DEFAULT_BASE_URL = PicksConfig.api_sports_football_url
    DEFAULT_TIMEOUT = 5

    # @return [String]
    attr_accessor :base_url
    # @return [Integer]
    attr_accessor :timeout
    # @return [Faraday::Connection] the current HTTP client
    attr_reader :http_client

    def initialize(base_url: DEFAULT_BASE_URL, timeout: DEFAULT_TIMEOUT)
      self.base_url = base_url
      self.timeout = timeout
      @http_client = initialize_http_client
    end

    # Executes the request, and returns the Response.
    #
    # @param method [Symbol]
    # @param url [String]
    # @param params [Hash]
    # @return [Faraday::Response]
    # @raise  [ApiSports::AuthenticationError]
    # @raise  [ApiSports::ConnectionError]
    # @raise  [ApiSports::ApiSportsError]
    # @raise  [ApiSports::SSLError]
    def request(method, url, params = {})
      response = http_client.send(method, url, params)
      raise_if_error(response)
      response
    rescue Faraday::ConnectionFailed
      raise ConnectionError.new, 'ApiSports connection failed'
    rescue Faraday::TimeoutError
      raise ConnectionError.new, 'ApiSports connection timeout'
    rescue Faraday::SSLError => exception
      raise SSLError.new, exception.message
    end

    private

    def initialize_http_client
      Faraday.new(base_url) do |faraday|
        faraday.use(Picks::FaradayLogger, namespace: 'api_sports')
        faraday.request :json
        faraday.response :json
        faraday.adapter Faraday.default_adapter
        faraday.options[:timeout] = timeout
        faraday.headers['Accept'] = 'application/json'
        faraday.headers['Content-Type'] = 'application/json'
        faraday.headers['x-apisports-key'] = PicksConfig.api_sports_key
      end
    end

    def raise_if_error(response)
      return if response.success?

      case response.status
      when 401
        raise AuthenticationError, 'Authentication error'
      else
        raise ApiSportsError, get_error_message(response)
      end
    end

    def get_error_message(response)
      return nil unless response&.body

      response.body
    end

  end
end
