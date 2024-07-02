# frozen_string_literal: true

class Round < ApplicationRecord

  belongs_to :league
  has_many :fixtures, dependent: :restrict_with_exception

  validates :name, :season, presence: true
  validates :name, uniqueness: { scope: %i[season league_id] }

end
