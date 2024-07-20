class AddScoreToFixtures < ActiveRecord::Migration[7.1]

  COMMENT = "Stores a detailed summary of a fixture scores".freeze

  def change
    add_column :fixtures, :score, :jsonb, comment: COMMENT
  end
end
