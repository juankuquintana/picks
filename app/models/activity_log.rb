# frozen_string_literal: true

class ActivityLog < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :account, optional: true

  validates :name, :actor, presence: true

  SYSTEM_ACTOR    = 'system'

  BET_INSERT      = 'bet.insert'
  POOL_CREATE     = 'pool.create'
  SESSION_CREATE  = 'session.create'
  SESSION_DESTROY = 'session.destroy'
  SESSION_FAILED  = 'session.failed'
  USER_CREATE     = 'user.create'

end
