# frozen_string_literal: true

class Round < ApplicationRecord

  belongs_to :league
  has_many :fixtures, dependent: :restrict_with_exception
  has_many :pools, dependent: :restrict_with_exception

  validates :name, :parameterized_name, :order, :season, presence: true
  validates :name, uniqueness: { scope: %i[season league_id], case_sensitive: false }
  validates :parameterized_name, uniqueness: { scope: %i[season league_id], case_sensitive: false }

end
