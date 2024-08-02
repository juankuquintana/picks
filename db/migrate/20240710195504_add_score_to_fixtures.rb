# frozen_string_literal: true

class AddScoreToFixtures < ActiveRecord::Migration[7.1]

  COMMENT = 'Stores a detailed summary of a fixture scores'

  def change
    add_column :fixtures, :score, :jsonb, comment: COMMENT
  end

end
