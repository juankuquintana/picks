# frozen_string_literal: true

class Fixture < ApplicationRecord

  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :round
  has_many :bets, dependent: :destroy

  validates :datetime, :adapters, presence: true
  validates :round_id, uniqueness: { scope: %i[home_team_id away_team_id] }

end
