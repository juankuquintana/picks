# frozen_string_literal: true

# Used to prefix or label communications (such as emails or logs)
set :environment_tag, "[#{Rails.env.upcase}]"

# Information of the website
set :site_host, 'localhost:3000'
set :site_name, 'Picks'

# Api Football configuration
set :api_sports_key, ENV.fetch('API_SPORTS_KEY', '')
set :api_sports_football_url, ENV.fetch('API_SPORTS_FOOTBALL_URL', 'https://v3.football.api-sports.io')

# AWS S3 configuration
set :aws_s3_access_key_id, ENV.fetch('AWS_S3_ACCESS_KEY_ID', '')
set :aws_s3_secret_access_key, ENV.fetch('AWS_S3_SECRET_ACCESS_KEY', '')
set :aws_s3_region, 'us-east-2'
set :aws_s3_public_bucket, 'picks-prd'
set :aws_s3_private_bucket, 'picks-private-prd'

# Google configuration
set :google_oauth_client_id, ENV.fetch('GOOGLE_OAUTH_CLIENT_ID', '')
set :google_oauth_client_secret, ENV.fetch('GOOGLE_OAUTH_CLIENT_SECRET', '')
set :google_oauth_skip_jwt, false

# New Relic configuration
set :new_relic_license, ENV.fetch('NEW_RELIC_LICENSE', '')

# Redis configuration
set :redis_url, ENV.fetch('REDIS_URL', 'redis://localhost:6379/8')

# Sentry configuration
set :sentry_key, ENV.fetch('SENTRY_KEY', '')
