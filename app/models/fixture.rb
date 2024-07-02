# frozen_string_literal: true

class Fixture < ApplicationRecord

  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :round

  validates :datetime, :adapters, presence: true

end
