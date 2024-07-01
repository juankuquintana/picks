# frozen_string_literal: true

class UserIdentity < ApplicationRecord

  belongs_to :user

  validates :email, :name, presence: true

  NAMES = %w[google].freeze
  enum name: NAMES.zip(NAMES).to_h

end
