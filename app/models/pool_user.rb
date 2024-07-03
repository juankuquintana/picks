# frozen_string_literal: true

class PoolUser < ApplicationRecord

  belongs_to :pool
  belongs_to :user

  validates :role, presence: true

  ROLE_ADMIN  = 'admin'
  ROLE_MEMBER = 'member'

  enum role: {
    admin: ROLE_ADMIN,
    member: ROLE_MEMBER
  }

end
