# frozen_string_literal: true

class Team < ApplicationRecord

  has_many :home_team_fixtures,
           foreign_key: :home_team_id,
           class_name: 'Fixture',
           dependent: :destroy,
           inverse_of: :home_team
  has_many :away_team_fixtures,
           foreign_key: :away_team_id,
           class_name: 'Fixture',
           dependent: :destroy,
           inverse_of: :away_team

  validates :name, :adapters, presence: true

end
