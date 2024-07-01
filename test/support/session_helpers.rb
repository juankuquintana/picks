# frozen_string_literal: true

module SessionHelpers

  def sign_in_via_oauth_as_user
    user = create(:user_with_account)

    Rails.application.env_config['omniauth.auth'] = oauth_mock(user, 'google')

    get '/auth/google/callback'
  end

  def sign_in_via_oauth_as_admin
    user = create(:admin_with_account)

    Rails.application.env_config['omniauth.auth'] = oauth_mock(user, 'google')

    get '/auth/google/callback'
  end

  def sign_in_via_oauth_as(user)
    Rails.application.env_config['omniauth.auth'] = oauth_mock(user, 'google')

    get '/auth/google/callback'
  end

  def setup_google_oauth(user)
    OmniAuth.config.test_mode = true

    Rails.application.env_config['omniauth.auth'] = oauth_mock(user, 'google')
  end

  protected

  def oauth_mock(user, provider)
    OmniAuth.config.mock_auth[provider.to_sym] = OmniAuth::AuthHash.new({
      provider:,
      uid: '12345678910',
      info: {
        email: user.email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
      },
      credentials: {
        token: 'abcdefgh12345',
        refresh_token: '12345abcdefgh',
        expires_at: DateTime.now
      }
    })
  end

end
