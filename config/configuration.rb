# frozen_string_literal: true

SimpleConfig.for :application do
  # Set here your global configuration.
  # All settings can be overwritten later per-environment.
  load Rails.root.join('config/settings/application.rb').to_s, if_exists?: true

  # Per Environment settings.
  # At startup only the file matching current environment will be loaded.
  # Settings stored here will overwrite settings with the same name stored in application.rb
  load Rails.root.join('config', 'settings', "#{Rails.env}.rb").to_s, if_exists?: true

  # Local settings. It is designed as a place for you to override variables
  # specific to your own development environment.
  # Make sure your version control system ignores this file otherwise
  # you risk checking in a file that will override values in production
  load Rails.root.join('config/settings/local.rb').to_s, if_exists?: true
end

PicksConfig = SimpleConfig.for(:application)
