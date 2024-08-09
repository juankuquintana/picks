# frozen_string_literal: true

# Flipper configuration
require 'active_support/cache'
require 'flipper/adapters/active_support_cache_store'

Flipper.configure do |config|
  config.adapter do
    Flipper::Adapters::ActiveSupportCacheStore.new(
        Flipper::Adapters::Memory.new,
        Rails.cache,
        expires_in: 30.minutes
      )
  end
end

Flipper.register(:admins) do |actor, _context|
  actor.respond_to?(:admin?) && actor.admin?
end

class CanAccessFeatureFlag

  def self.matches?(request)
    user, = Session::AuthenticateService.call(request).result
    user.present? && user.admin?
  end

end

# Sentry configuration
Sentry.init do |config|
  config.dsn = PicksConfig.sentry_key
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.traces_sample_rate = 1.0
  config.enabled_environments = %w[production]
end

# Sidekiq configuration
Sidekiq.configure_server do |config|
  config.on(:startup) do
    schedule_file = 'config/schedule.yml'

    raise 'Sidekiq schedule file is not configured' unless File.exist?(schedule_file)

    schedule = YAML.load_file(schedule_file)
    # Sidekiq::Cron::Job.load_from_hash!(schedule, source: 'schedule')
  end

  config.redis = { url: PicksConfig.redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: PicksConfig.redis_url }
end

class CanAccessSidekiq

  def self.matches?(request)
    user, = Session::AuthenticateService.call(request).result
    user.present? && user.admin?
  end

end
