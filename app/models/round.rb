# frozen_string_literal: true

class Round < ApplicationRecord

  belongs_to :league

  validates :name, :season, presence: true
  validates :name, uniqueness: { scope: %i[season league_id] }

end
