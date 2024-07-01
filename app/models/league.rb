# frozen_string_literal: true

class League < ApplicationRecord

  belongs_to :country
  has_many :rounds

  validates :name, :logo, :adapters, presence: true

end
