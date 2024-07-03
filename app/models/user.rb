# frozen_string_literal: true

class User < ApplicationRecord

  has_many :memberships, dependent: :destroy
  has_many :accounts, through: :memberships
  has_many :activity_logs, dependent: :destroy
  has_many :user_identities, dependent: :destroy
  has_many :pools, through: :pool_users, dependent: :destroy
  has_many :bets, dependent: :destroy

  has_secure_token :session_token

  validates :email, presence: true
  validates :email, uniqueness: true

  def primary_account
    memberships.find_by(primary: true).account
  end

  def admin?
    admin_at.present?
  end

end
