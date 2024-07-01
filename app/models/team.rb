# frozen_string_literal: true

class Team < ApplicationRecord

  validates :name, :adapters, presence: true

end
