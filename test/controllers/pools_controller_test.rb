# frozen_string_literal: true

require 'test_helper'

class PoolsControllerTest < ActionDispatch::IntegrationTest

  describe 'POST /pools' do
    before do
      Pools::CreateInteractor.stubs(:result).returns(InteractorStub.new)

      @league = create(:league)
      round = create(:round, league: @league, season: 2024)
      create(:fixture, round:, datetime: DateTime.now + 5.minutes)
    end

    it 'succeeds' do
      user = create(:user_with_account)
      sign_in_via_oauth_as(user)

      Pools::CreateInteractor.expects(:call).with(anything, anything, anything).returns(InteractorStub.new)

      post pools_path, params: { name: 'Quiniela', league: @league.id }

      assert_redirected_to home_path
    end

    it 'delegates to Pools::CreateInteractor' do
      user = create(:user_with_account)
      sign_in_via_oauth_as(user)

      Pools::CreateInteractor.expects(:call).with(anything, anything, anything).returns(InteractorStub.new)

      post pools_path
    end

    it 'routes to /pools' do
      assert_routing({ method: 'post', path: 'pools' }, { controller: 'pools', action: 'create' })
    end

    it_requires_authentication do
      post pools_path
    end
  end

  describe 'GET /pools/:pool_id' do
    it 'succeeds' do
      user = create(:user_with_account)
      sign_in_via_oauth_as(user)

      pool = create(:pool)
      create(:pool_user, pool:, user:)

      get pool_path(pool.id)
    end

    it 'routes to /pools/:pool_id' do
      assert_routing '/pools/3', controller: 'pools', action: 'show', id: '3'
    end

    it_requires_authentication do
      get pool_path(3)
    end
  end

end
