# frozen_string_literal: true

require 'test_helper'

class PoolUserTest < ActiveSupport::TestCase

  context 'associations' do
    should belong_to(:pool).class_name('Pool')
    should belong_to(:user).class_name('User')
  end

  context 'validations' do
    subject { build(:pool_user) }

    should define_enum_for(:role).backed_by_column_of_type(:string)
  end

end
