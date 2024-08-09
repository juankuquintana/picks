# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'bootsnap', require: false
gem 'rails', '~> 7.1.3'

gem 'aws-sdk-s3', require: false
gem 'dotenv-rails', '3.0.0.beta'
gem 'faraday', '~> 2.9'
gem 'faraday-multipart', '~> 1.0', '>= 1.0.4'
gem 'flipper'
gem 'flipper-active_record'
gem 'flipper-active_support_cache_store'
gem 'flipper-ui'
gem 'importmap-rails'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'nokogiri'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'overcommit', require: false
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'service_actor', '~> 3.7'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'simpleconfig', '~> 2.0', '>= 2.0.1'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'turbo-rails'

group :development do
  gem 'letter_opener'
end

group :development, :test do
  gem 'erb_lint', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'capybara'
  gem 'cuprite'
  gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
  gem 'faker', '~> 3.2', '>= 3.2.3'
  gem 'minitest', '~> 5.22', '>= 5.22.2'
  gem 'minitest-spec-rails'
  gem 'mocha', '~> 2.1'
  gem 'shoulda', '~> 4.0'
  gem 'timecop'
  gem 'webmock'
end
