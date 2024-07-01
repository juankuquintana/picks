# frozen_string_literal: true

module Picks
  class FaradayLogger < Faraday::Middleware

    def initialize(app, options = {})
      super(app)

      @logger = options.fetch(:logger) do
        require 'logger'
        ::Logger.new($stdout)
      end

      @namespace = options[:namespace]
    end

    def on_request(env)
      return if Rails.env.test?

      @logger.info("[#{@namespace}.http_request:started] #{env.method.upcase} #{env.url} #{env.body}")
    end

    def on_complete(env)
      return if Rails.env.test?

      @logger.info("[#{@namespace}.http_request:finished] #{env.status} #{env.method.upcase} #{env.url} #{env.body}")
    end

  end
end
