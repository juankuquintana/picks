# frozen_string_literal: true

class Country < ApplicationRecord

  has_many :leagues, dependent: :restrict_with_exception

  validates :name, presence: true

end
