# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, PicksConfig.google_oauth_client_id, PicksConfig.google_oauth_client_secret,
           {
             scope: 'email, profile, openid',
             image_aspect_ratio: 'square',
             image_size: 50,
             access_type: 'offline',
             name: 'google',
             prompt: 'select_account',
             callback_path: '/auth/google/callback',
             skip_jwt: PicksConfig.google_oauth_skip_jwt
           }
end
