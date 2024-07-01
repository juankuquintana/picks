# frozen_string_literal: true

require 'test_helper'

module Session
  class DestroyServiceTest < ActiveSupport::TestCase

    describe '#call' do
      it 'clears the session' do
        user = create(:user)
        request = Rack::Request.new({ 'rack.session' => { Picks::Constants::SESSION_USER_CREDENTIALS_KEY => user.session_token } })

        described_class.call(user, request)

        assert_nil request.session[Picks::Constants::SESSION_USER_CREDENTIALS_KEY]
      end

      it 'resets the session token' do
        user = create(:user)
        session_token = user.session_token
        request = Rack::Request.new({ 'rack.session' => { Picks::Constants::SESSION_USER_CREDENTIALS_KEY => session_token } })

        described_class.call(user, request)

        assert_not_equal user.reload.session_token, session_token
      end

      it 'records the activity' do
        user = create(:user)
        request = Rack::Request.new({ 'rack.session' => { Picks::Constants::SESSION_USER_CREDENTIALS_KEY => user.session_token } })

        Picks::Event.expects(:notify).with(ActivityLog::SESSION_DESTROY, anything, anything, anything, anything)

        described_class.call(user, request)
      end
    end

  end
end
