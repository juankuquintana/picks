# frozen_string_literal: true

class Fixture < ApplicationRecord

  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :round
  has_many :bets, dependent: :destroy

  validates :datetime, :adapters, presence: true
  validates :round_id, uniqueness: { scope: %i[home_team_id away_team_id] }
  validates :state, presence: true

  STATE_NOT_STARTED = 'not_started'
  STATE_IN_PROGRESS = 'in_progress'
  STATE_FINISHED    = 'finished'
  STATE_POSTPONED   = 'postponed'

  enum state: {
    not_started: STATE_NOT_STARTED,
    in_progress: STATE_IN_PROGRESS,
    finished: STATE_FINISHED,
    postponed: STATE_POSTPONED
  }

end
