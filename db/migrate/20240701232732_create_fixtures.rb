# frozen_string_literal: true

class CreateFixtures < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores a fixture or match information'

  def change
    create_table :fixtures, comment: TABLE_COMMENT do |t|
      t.datetime :datetime, comment: 'The date time a match is played'
      t.integer :home_team_score, comment: 'The home team score'
      t.integer :away_team_score, comment: 'The away team score'
      t.jsonb :adapters, null: false, comment: 'Stores the reference IDs of the fixture from our different providers'
      t.references :home_team, foreign_key: { to_table: :teams }, null: false, comment: 'References the home team associated to this fixture'
      t.references :away_team, foreign_key: { to_table: :teams }, null: false, comment: 'References the away team associated to this fixture'
      t.references :round, foreign_key: true, null: false, comment: 'References the round associated to this fixture'

      t.timestamps
    end

    add_index :fixtures, %i[round_id home_team_id away_team_id], unique: true
  end

end
