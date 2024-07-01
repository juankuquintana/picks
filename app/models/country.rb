# frozen_string_literal: true

class Country < ApplicationRecord

  has_many :leagues

  validates :name, presence: true

end
