# frozen_string_literal: true

require 'test_helper'

module Session
  class CreateServiceTest < ActiveSupport::TestCase

    describe '#call' do
      it 'sets the session' do
        user = create(:user)
        request = Rack::Request.new({})

        described_class.call(user, request)

        assert_equal user.session_token, request.session[Picks::Constants::SESSION_USER_CREDENTIALS_KEY]
      end

      it 'records the activity' do
        user = create(:user)
        request = Rack::Request.new({})

        Picks::Event.expects(:notify).with(ActivityLog::SESSION_CREATE, anything, anything, anything, anything)

        described_class.call(user, request)
      end
    end

  end
end
