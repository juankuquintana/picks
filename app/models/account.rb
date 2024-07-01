# frozen_string_literal: true

class Account < ApplicationRecord

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :activity_logs, dependent: :destroy

  validates :email, presence: true
  validates :email, uniqueness: true

end
