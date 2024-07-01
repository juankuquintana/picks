# frozen_string_literal: true

set :site_host, 'picks.games'

set :mailer_port, ENV.fetch('MAILER_PORT', '')
set :mailer_domain, ENV.fetch('MAILER_DOMAIN', '')
set :mailer_user, ENV.fetch('MAILER_USER', '')
set :mailer_password, ENV.fetch('MAILER_PASSWORD', '')
