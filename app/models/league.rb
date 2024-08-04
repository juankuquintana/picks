# frozen_string_literal: true

class League < ApplicationRecord

  belongs_to :country
  has_many :rounds, dependent: :destroy
  has_many :pools, dependent: :destroy

  validates :name, :logo, :adapters, presence: true
  validates :state, presence: true

  scope :ongoing, -> { where('season_start <= ? AND season_end >= ?', Time.zone.today, Time.zone.today) }

  STATE_ACTIVE = 'active'

  enum state: {
    active: STATE_ACTIVE
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
