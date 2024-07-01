# frozen_string_literal: true

class FeatureFlagQuery

  # All feature flags should be defined here as symbols.

  # Returns the feature flag value for a given feature
  #
  # @param feature [Symbol] the feature to check
  # @return [Boolean] the feature flag value
  def self.enabled?(feature)
    Flipper.enabled?(feature)
  end

  # Returns the feature flag value for a given feature
  #
  # @param feature [Symbol] the feature to enable
  # @param user [User] the user that is requesting access to the feature
  # @return [Boolean] the feature flag value
  def self.enabled_for_user?(feature, user)
    Flipper.enabled?(feature, user)
  end

end
