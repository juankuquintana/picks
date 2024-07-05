# frozen_string_literal: true

class CreateRounds < ActiveRecord::Migration[7.1]

  TABLE_COMMENT = 'This table stores the name of the rounds (jornadas) or matchdays of a season'

  def change
    create_table :rounds, comment: TABLE_COMMENT do |t|
      t.string :name, limit: 255, null: false, comment: 'The round name'
      t.integer :order, null: false, comment: 'The round order within a season'
      t.string :season, null: false, comment: 'The season / year (YYYY) of the round'
      t.integer :group, comment: 'Group to which the round belongs to, helpful when leagues have multiple seasons per year'
      t.references :league, foreign_key: true, null: false, comment: 'References the league associated to this round'

      t.timestamps
    end

    add_index :rounds, %i[name season league_id], unique: true
  end

end
