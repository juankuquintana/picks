# frozen_string_literal: true

class Pool < ApplicationRecord

  belongs_to :league
  belongs_to :round
  has_many :pool_users, dependent: :destroy
  has_many :users, through: :pool_users, dependent: :destroy
  has_many :bets, dependent: :destroy

  validates :name, :code, presence: true
  validates :code, uniqueness: true

end
