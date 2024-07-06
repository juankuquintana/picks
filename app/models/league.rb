# frozen_string_literal: true

class League < ApplicationRecord

  belongs_to :country
  has_many :rounds, dependent: :destroy
  has_many :pools, dependent: :destroy

  validates :name, :logo, :adapters, presence: true

  def adapter_data
    adapters.first
  end

end
