# frozen_string_literal: true

class League < ApplicationRecord

  belongs_to :country
  has_many :rounds, dependent: :destroy
  has_many :pools, dependent: :destroy

  validates :name, :parameterized_name, :logo, :adapters, presence: true
  validates :state, presence: true
  validates :parameterized_name, uniqueness: { case_sensitive: false }

  scope :active, -> { where(state: STATE_ACTIVE) }
  scope :ongoing, -> { where('season_start <= ? AND season_end >= ?', Time.zone.today, Time.zone.today) }

  STATE_ACTIVE   = 'active'
  STATE_INACTIVE = 'inactive'

  enum state: {
    active: STATE_ACTIVE,
    inactive: STATE_INACTIVE
  }

  def adapter_data
    adapters.first
  end

  def most_recent_season
    rounds.order('season ASC').last&.season
  end

  def ongoing
    today = Time.zone.today
    season_start <= today && season_end >= today
  end

end
