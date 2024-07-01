# frozen_string_literal: true

require 'test_helper'

module Session
  class GoogleAuthenticateInteractorTest < ActiveSupport::TestCase

    include Rails.application.routes.url_helpers

    describe '#call' do
      it 'succeeds' do
        Session::GoogleAuthenticateService.any_instance.stubs(:call)

        result = described_class.call(email: 'admin@google.com', name: 'Elon Musk', request: nil)
        assert result.success?
        assert_equal result.redirect_url, home_path
      end

      it 'delegates to Session::GoogleAuthenticateService' do
        email = 'admin@google.com'
        name = 'Elon Musk'
        request = nil

        Session::GoogleAuthenticateService.expects(:call).with(email, name, request)

        described_class.call(email:, name:, request:)
      end
    end

  end
end
