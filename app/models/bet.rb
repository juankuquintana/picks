# frozen_string_literal: true

class Bet < ApplicationRecord

  belongs_to :fixture
  belongs_to :pool
  belongs_to :user

  validates :home_team_score, :away_team_score, presence: true
  validates :fixture_id, uniqueness: { scope: %i[pool_id user_id] }

end
