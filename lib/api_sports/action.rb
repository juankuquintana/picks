# frozen_string_literal: true

require_relative 'client'

module ApiSports
  class Action

    METHOD_GET  = :get
    METHOD_POST = :post

    attr_accessor :client

    def initialize(client: ApiSports::Client.new)
      @client = client
    end

    def execute(method, path, params)
      client.request(method, path, params)
    end

    private

    # Takes a date string and returns a Date representation
    #
    # @param date_string [String] A Date represented as YYYY-MM-DD
    # @return [Date]
    def parse_date(date_string)
      return nil unless date_string

      Date.parse(date_string)
    end

    # Takes a date string and returns a Date representation
    #
    # @param date_string [String] A Date represented as ISO8601
    # @return [Date]
    def parse_date_time(date_string)
      return nil unless date_string

      DateTime.parse(date_string)
    end

    def extract_defaults(response)
      {
        errors: response['errors'],
        count: response['results'],
        page: response.dig('paging', 'current'),
        total_pages: response.dig('paging', 'total')
      }
    end

  end
end
