# frozen_string_literal: true

require 'test_helper'

module Session
  class AuthenticateServiceTest < ActiveSupport::TestCase

    describe '#call' do
      it 'succeeds' do
        user = create(:user)
        request = Rack::Request.new({ 'rack.session' => { Picks::Constants::SESSION_USER_CREDENTIALS_KEY => user.session_token } })

        service = described_class.call(request)
        assert_equal service.result, user
      end

      describe 'when no session is found' do
        it 'returns nil' do
          service = described_class.call(Rack::Request.new({}))
          assert_nil service.result
        end
      end
    end

  end
end
